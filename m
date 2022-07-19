Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC93579192
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiGSEAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiGSEAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:00:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E5831398
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8B0561474
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BC1C341C6;
        Tue, 19 Jul 2022 04:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658203233;
        bh=9VMONji9BerSyoU2yWF56/lXSgMyUMlCRBLz8u7B6Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBapORU77k0+89X5Dgg/xxAS5WPHYynvmG03myEdBjku/E429Lqz0qwSjMKjIoKOv
         0psm4Ep4WJF765dCDoO4x3iyKZmtlYmafCJATiyensokcmLD07KkcAFUzzYoFd38nl
         CvoFS56MVbLR7yq7DTLFeS3oejAWGtziElcJNE5EqHJyCa+eJs4OtSLQKQKaMN58Ux
         Jzu2+dyrdmayZ/wYT9cgfwGiQu47gDhOfmm6PzHG/LF6f5osLI/ac47+WpAj0zMw20
         0sayZS+I1Rw5Lni/u5+WVukubBi2HOr1zYKXbEzC6eHRgOD0PnNma38ltDAfHRteLQ
         1WA5XaeJOuRGg==
Date:   Tue, 19 Jul 2022 04:00:30 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/10] platform/chrome: cros_kunit_util: add default
 value for `msg->result`
Message-ID: <YtYsXvi9WfdLFCiu@google.com>
References: <20220718050914.2267370-1-tzungbi@kernel.org>
 <20220718050914.2267370-2-tzungbi@kernel.org>
 <CABXOdTfYAGapjkPxRC4SbKMKEwCWmrF46aEDFWvsMBqaTuCzPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTfYAGapjkPxRC4SbKMKEwCWmrF46aEDFWvsMBqaTuCzPA@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 06:35:42AM -0700, Guenter Roeck wrote:
> On Sun, Jul 17, 2022 at 10:10 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > +int cros_kunit_ec_xfer_mock_default_result;
> > +EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_result);
> 
> Is this needed as a global variable and, if so, does it really have to
> be exported ?
> 
> >  int cros_kunit_ec_xfer_mock_default_ret;
> >  EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_ret);
> 
> Same here, really, only I didn't notice before.

Global variables: I'm afraid yes.  They should be accessible to test cases
(e.g. drivers/platform/chrome/cros_ec_proto_test.c).

Exported: I'm not sure if I fixed it in a proper way.  They were added for
fixing https://lkml.org/lkml/2022/6/2/452.  When CONFIG_CROS_KUNIT=m and
CONFIG_CROS_EC_PROTO_KUNIT_TEST=m, cros_ec_proto_test.c still needs to access
them (in cros_kunit_util.c).
