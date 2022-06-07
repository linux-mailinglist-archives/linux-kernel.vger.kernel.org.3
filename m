Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08AF53F321
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 02:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbiFGA4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 20:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbiFGA4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 20:56:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D157EC0380
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:56:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63BCFB81C76
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1D0C34119;
        Tue,  7 Jun 2022 00:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654563358;
        bh=Fa+ZVxzeyJ9yJ+VVCe9A6YpbQZseNSAiFrLgkiUyuGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5ow9tJ8FUC/Vn/7SIZqlnep0+WUO0ETAyF1qjdc8KI/B1xlAw5l44T0fpYkjsgrM
         c0qDG1yRNe8f34dJs6M5h5wTUKU3JKejrw0nepQDQ7WVWEPE0qjG0vc2iwrsg8q9BG
         tAvbriGnKX9JtsSnpcFOmffdFvVyLXrBWkg2m/GGGJnEDTxapZY0qPLItiI3TukfiK
         wysouARz++ICszZr06IoJ2YgIYC2XWqoH6FDBHi7EScDMccnxpJ5Yl1W+4cGZndOuL
         Ht/cWbF2XfmgEYRJebULxFHqFkoBYrT+0pv20Ii0vW0EJWpkxLJ0y90410yWWAdwrj
         cKJRqSB9EmrgQ==
Date:   Tue, 7 Jun 2022 00:55:55 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/13] platform/chrome: cros_ec_proto: fix
 get_host_event_wake_mask() returns
Message-ID: <Yp6iG75RmirxRMu2@google.com>
References: <20220606141051.285823-1-tzungbi@kernel.org>
 <20220606141051.285823-14-tzungbi@kernel.org>
 <CABXOdTdvcycr-U2VniJSLqbvt=tiEDBmo+EUSx1eX8Nti8cXAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTdvcycr-U2VniJSLqbvt=tiEDBmo+EUSx1eX8Nti8cXAg@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 09:14:26AM -0700, Guenter Roeck wrote:
> On Mon, Jun 6, 2022 at 7:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > @@ -256,19 +256,16 @@ static int get_host_event_wake_mask(struct cros_ec_device *ec_dev, uint32_t *mas
> >         msg->insize = sizeof(*r);
> >
> >         ret = send_command(ec_dev, msg);
> > -       if (ret >= 0) {
> > +       if (ret > 0) {
> 
> The idea here was to (potentially) return an error if ret == 0. This
> is no longer the case after this change. Instead, the caller has to
> check for ret == 0 and treat it as an error. I think it would make
> more sense to explicitly check for ret ==0, eg with something like
> 
>     mapped = cros_ec_map_error(msg->result);
>     if (mapped) {
>         ret = mapped;
>         goto exit;
>     }
>     if (ret == 0) {
>         ret = -EPROTO;
>         goto exit;
>     }
>     ....

Ack, will fix in next version.
