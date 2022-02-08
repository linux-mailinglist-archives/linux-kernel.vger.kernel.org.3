Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18E34AD155
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbiBHGDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbiBHGDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:03:34 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDED2C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 22:03:31 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id m6so46797284ybc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 22:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMy2hRWsW4BXhakNBZo4Ma5dYlVtSB1pupcqWZPcuMI=;
        b=kvk1jcZaq+k/Iwu3RIeroimUiDS+lPWwHyJtqt4TLLIy5da2ssF18ys78lP1+rVg0Z
         pSpTWY0jk82CS/yXxgIwVnRerVRQEOWD3HVuX44bGybNPpsW+OTzfZwDWLcb5VptzK+O
         lmbVPl2qu8GdgocQk9tsmwzO7yGYPJmoWU8+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMy2hRWsW4BXhakNBZo4Ma5dYlVtSB1pupcqWZPcuMI=;
        b=cf94wzvKq4VHRXv0+uRI2pXrL3Ws+xU89sBJKF0Ig8m7XpdbdEPgZT6upRXQzN2OBi
         jcf2nlnfllNVi2JpUXqzgPX9jvBuzFStD12HtIDSnnlpSMTU/jBkfG9fIA+zeANQC1mu
         r92hbbf1N+SJF8nN1hKr/UfSEmv6niQR9V97jy3mdMuVhOTaeHUQpGsXJY2maugh70Cf
         2Cu1RBbio4/qhBZgqjTMSgS3YirKI5SHVTzKVmfPS/wLsAq9oqUNapgrENDdbmJ4OP8W
         /pNl0Ul4MFgkB+Y/ZWJFCW5guk8ahOBRtDfQYSdOAogIqtfGXYtZOPmeufNeqcRRiive
         lptw==
X-Gm-Message-State: AOAM5318yNcDnUeaxdk5rLNK+EVKCOI5Pe3A9lsz1d3a1IV0JZ4zZft8
        kLzEns3somBGjR0jcFA0ZsDvct7fzTHJCuKZ6ycf3A==
X-Google-Smtp-Source: ABdhPJzLJ+I6iKDCyYDLbD3jS0wm/Y7PBtmB4ohNMMY4516lTpj2oaCH6aihTPhiO0sYKMvXLFdQcjhnENV2mU7pJSI=
X-Received: by 2002:a25:be43:: with SMTP id d3mr3132634ybm.454.1644300211036;
 Mon, 07 Feb 2022 22:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20220207214026.1526151-1-pmalani@chromium.org>
 <20220207214026.1526151-2-pmalani@chromium.org> <YgIAl8do1/b1Dru9@google.com>
In-Reply-To: <YgIAl8do1/b1Dru9@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 7 Feb 2022 22:03:19 -0800
Message-ID: <CACeCKafU5OgwidJJ5TeBani-gfBTo-Qk0fXi7n=r6pLkTK7ApA@mail.gmail.com>
Subject: Re: [PATCH 1/4] platform/chrome: cros_ec_typec: Move mux flag checks
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,

On Mon, Feb 7, 2022 at 9:33 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Mon, Feb 07, 2022 at 09:40:24PM +0000, Prashant Malani wrote:
> > Move mux and role flag checks inside of cros_typec_configure_mux(),
> > which is a more logical location for them.
>
> nit: s/Move/Moves/.

Move is fine. Please see:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes

Quoting from the above: " Describe your changes in imperative mood,"

>
> > @@ -519,7 +519,14 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
> >       struct cros_typec_port *port = typec->ports[port_num];
> >       struct ec_params_usb_pd_mux_ack mux_ack;
> >       enum typec_orientation orientation;
> > -     int ret;
> > +     int ret = 0;
>
> The change looks irrelevant to the patch.
Ack, I missed eliminating this while cleaning up the patches. Will fix
it in the next version.
