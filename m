Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068114F213A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiDECxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiDECxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:53:13 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488BE1F36CA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 19:24:16 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2eb888cf7e7so32961877b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 19:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RnXh2T/U2DQgOhkSzIbFktnchft1/air72kA5hMo268=;
        b=RdwMLiCbc2L1okaRCJ5jKZCfuFRsTM9cXzjiSWYLcgbsCu0E+KP0UXHPC/XEeWzI2E
         HJMdvWG8nDGuw9EJCL1ELqu7XYRGL8uLL1jqYE5tpCUrKnyhaHsUgOxIz4tfX/zbckr6
         5VxPifMdFSOXgAWNjfZy0BJTka7RxhM8tTmXTeYYdw2jTm6upeOeyb2SyAELkK0sFK5m
         ynuNMe7aqe6IXZl7zeDaWTlMG2cFJ2psIOMtEV9duqmvJi3p0zUOpGrEaTs7OmhjO7Yg
         e//dbCIlc+9mSnXF7H0JfJAzZ9fCe1vgs92Ua6a3TMH7UtAmjHMaSwxcK7U9rIuvPAbx
         Luyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RnXh2T/U2DQgOhkSzIbFktnchft1/air72kA5hMo268=;
        b=UbiThuRXuHthnug5vGl/9qi1fV/ZgK5sMHUMzbTFD2xSLVth3pf+aaG2hykBdCPdPK
         yRRmIva8nIH2tmpd02yy7HpoBtmLOJhkKKp29I8IY36bwR/twnVxxCcg4cJkYyHnAFVs
         16M8KVd7pOgZ0K64D/wLZnuAR3cctnHqjuscxoQKV0lvBzbcP4ZXm0Mo0bYN8SSD69g9
         6wUSCRsfx/zFs8T9zUj0uzNrUwbGxkUiF1+/2vSWffC4ZIHuOJEv6pxYQzL6h8pR8Jqs
         vwfanFSZryIBWOyrqVYeHGGSHVIAfT2yBio8zMDsA/efMWrmTncepqiM3FYayrQKhalI
         cJtg==
X-Gm-Message-State: AOAM533052FnADcHdibDAl0CI9u4Va9EqNVpKlHG+NcsM88hSTmKOE6a
        vGdpe4U+7Bvt66VOSS7tNeiN1sUIQRY/lZNGOD00cw==
X-Google-Smtp-Source: ABdhPJySsUEslHirJOU6d+eWhv0nlmjDy80xPo+99g8US0EzUqOSorg2gcZ3kxZNalPl6FYgoXtO5j2kdwqG9ggJCqI=
X-Received: by 2002:a81:106:0:b0:2d0:e682:8a7a with SMTP id
 6-20020a810106000000b002d0e6828a7amr945563ywb.257.1649125455349; Mon, 04 Apr
 2022 19:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220404054642.3095732-1-tweek@google.com> <YkqtZFuMpYxDBAH+@kroah.com>
In-Reply-To: <YkqtZFuMpYxDBAH+@kroah.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Tue, 5 Apr 2022 12:23:59 +1000
Message-ID: <CA+zpnLfA7-eWb8dO3=VsOzyzUa8ycZxmxG9T2bkWVOcFVp4gKQ@mail.gmail.com>
Subject: Re: [PATCH] firmware_loader: use kernel credentials when reading firmware
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 6:33 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Apr 04, 2022 at 03:46:42PM +1000, Thi=C3=A9baud Weksteen wrote:
> > Device drivers may decide to not load firmware when probed to avoid
> > slowing down the boot process should the firmware filesystem not be
> > available yet. In this case, the firmware loading request may be done
> > when a device file associated with the driver is first accessed. The
> > credentials of the userspace process accessing the device file may be
> > used to validate access to the firmware files requested by the driver.
> > Ensure that the kernel assumes the responsibility of reading the
> > firmware.
> >
> > This was observed on Android for a graphic driver loading their firmwar=
e
> > when the device file (e.g. /dev/mali0) was first opened by userspace
> > (i.e. surfaceflinger). The security context of surfaceflinger was used
> > to validate the access to the firmware file (e.g.
> > /vendor/firmware/mali.bin).
> >
> > Because previous configurations were relying on the userspace fallback
> > mechanism, the security context of the userspace daemon (i.e. ueventd)
> > was consistently used to read firmware files. More devices are found to
> > use the command line argument firmware_class.path which gives the kerne=
l
> > the opportunity to read the firmware directly, hence surfacing this
> > misattribution.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > ---
> >  drivers/base/firmware_loader/main.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
>
> Is this a bugfix?  if so, what commit does this fix?  If not, how has
> this never been a problem in the past (i.e. what changed to cause
> problems?)

Not a bug fix. I think this is the combination of 3 factors that
surfaces the issue:

1. As mentioned in the last paragraph of the commit, previously, the
userspace fallback was used (that is, udev/ueventd would read the
firmware file so only this process would need the correct permission
to access the files). More devices are using firmware_class.path=3D
which causes the kernel to try to load the firmware directly[1].

2. Drivers are calling request_firmware when handling a userspace
request (such as open() on a device file). Historically,
request_firmware seems to have been called when probe() was invoked by
the kernel.

3. The precise MAC policy on Android (as opposed to DAC where the
firmware files are own by root and a root process accesses the device
file).

Thanks,

[1] https://www.kernel.org/doc/html/v5.17/driver-api/firmware/fw_search_pat=
h.html

> thanks,
>
> greg k-h
