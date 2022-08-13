Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25A75917E9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 02:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbiHMAxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 20:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiHMAxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 20:53:45 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9743832BA4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 17:53:43 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3246910dac3so24419447b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 17:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=36BlJ/HsCSRIMIGdfkPkYgLTxa2hQ9NSNPcVB/JXrLw=;
        b=I8A6WblWDTfttpwEjzWX2ZfKNP3Vit8ls7jbhoGQdskcFbRQiYEaLoFlEK90L9x1fX
         XSqL8vEkEchRdSyyoXYsbD46FtMAQMXpEcnp2z290EFBt4eiTqGRLv9J9GfqYadFClKs
         fWHyFAryo1OTZpRzoOKZg1mKiaficZ78ksaXJ2BUHZo1B8VtznkkvM2Hcl+ila/B1TJG
         RcX42R6aQcRREbdXjHlO1PIB8cq18IyfZpsWO0Wmoc7rYASB2wZvEtFFNuysvi28qWbP
         MCrEXNh7HQ47kVsBTk7hIQll3+3FhBu7k56c2gx+33wR+9vG/KJ9FSVlhZb8pdP7+iUh
         XUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=36BlJ/HsCSRIMIGdfkPkYgLTxa2hQ9NSNPcVB/JXrLw=;
        b=Fp/hVxfcUbVjmVh4QQH8PsYbTPeruXukQEzYOqyID7NTIQcApMhOzvvfrNt8ACSj4W
         g3f0SznzkVpZo4Qk19cDiNVuqfrqjGIhY1SMnWNtI2bWoq7/VAiFqPxyDYCB/p2OeD4z
         lyQJ79QTN1DpQNPC2HgAuMgV+7N7sHh6A8VXIRgXSovmA/scoAmVMb4KHJEAUNu4qTzo
         CSctRu45kDOs/32jAMZ+iX57zsLHD0j4aPo970CY9PGVTNq5M0KLVaMVZW6tx0ZSLEvM
         aUHL6R+VeU5YMKIBdd4oTSXG89TuvOzBVTjwKe8MgfpzlX8z1QaYUsVCj4Nsx7X/5YsI
         azqQ==
X-Gm-Message-State: ACgBeo16d5CRAgPBDIUD93TLuYnH3rj/lZR2CSRXsxl/Tf+yvTDPcPf7
        jJF1RUMQtZyszHvlouIbigZy8sswVBNBL3oVREnEBw==
X-Google-Smtp-Source: AA6agR6onfzJ7FRispH2xbJsvurzqkwlJ9rKreeSUVQHLLNnnn5qj4+gH3uHUu4DGwsbO/e1Rm8eGBC5RBa2lWrxI3g=
X-Received: by 2002:a0d:fd05:0:b0:329:3836:53ac with SMTP id
 n5-20020a0dfd05000000b00329383653acmr6042709ywf.455.1660352022736; Fri, 12
 Aug 2022 17:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt_cc5SiNv1Vbse=HYY_+uc+9OYPZuJ-x59bROSaLN6fw@mail.gmail.com>
 <CAGETcx8bGwDkPP=d2MtcY69YmTyckUSa8xAwNVOPOyTR8jPk=A@mail.gmail.com> <CA+G9fYv0DFZi2rMPQTHvK8yD7g0LZTxN76iKZxP4pi4+8Rstxg@mail.gmail.com>
In-Reply-To: <CA+G9fYv0DFZi2rMPQTHvK8yD7g0LZTxN76iKZxP4pi4+8Rstxg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 12 Aug 2022 17:53:06 -0700
Message-ID: <CAGETcx9Fae8tVhf+JrbYTnau5njLmjz75u-gJGkT6f7wjVdCyg@mail.gmail.com>
Subject: Re: [next] arm: PM: domains: Delete usage of driver_deferred_probe_check_state()
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jul 27, 2022 at 10:35 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Hi Saravana,
>
> On Thu, 28 Jul 2022 at 00:19, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Tue, Jul 26, 2022 at 11:44 PM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > Linux next arm BeagleBoard x15 device boot failed due to the
> >
> > Can you point me to the dts file that corresponds to this board
> > please? And if you know which devices are power domains, that'd be
> > handy too. For now, I'm reverting this patch.
> metadata:
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 9250d2f72dc46a808b6aa23bf50dd670f1f52ddc
>   git_describe: v5.19-rc7-13490-g9250d2f72dc4
>   git_ref: master
>   kernel_version: 5.19.0-rc8
>   kernel-config: https://builds.tuxbuild.com/2CWh3jswUGEkjvfXQPGXdOceMFH/config
>   artifact-location: https://builds.tuxbuild.com/2CWh3jswUGEkjvfXQPGXdOceMFH
>   toolchain: gcc-10
>
> I am sharing a few urls, metadata, test job link and device details link.
>
>       kernel:
>         url: https://builds.tuxbuild.com/2CWh3jswUGEkjvfXQPGXdOceMFH/zImage
>       dtb:
>         url: https://builds.tuxbuild.com/2CWh3jswUGEkjvfXQPGXdOceMFH/dtbs/am57xx-beagle-x15.dtb
>       modules:
>         url: https://builds.tuxbuild.com/2CWh3jswUGEkjvfXQPGXdOceMFH/modules.tar.xz
>
> Test jobs url:
>        - https://lkft.validation.linaro.org/scheduler/job/5326314#L1982
>
> Device details link,
>       - https://www.ti.com/tool/BEAGLEBOARD-X15
>
> metadata:
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 9250d2f72dc46a808b6aa23bf50dd670f1f52ddc
>   git_describe: v5.19-rc7-13490-g9250d2f72dc4
>   git_ref: master
>   kernel_version: 5.19.0-rc8
>   kernel-config: https://builds.tuxbuild.com/2CWh3jswUGEkjvfXQPGXdOceMFH/config
>   artifact-location: https://builds.tuxbuild.com/2CWh3jswUGEkjvfXQPGXdOceMFH
>   toolchain: gcc-10
>

Ah, I forgot to CC you on a series that might fix this. Can you give
this a shot please?

https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/

Thanks,
Saravana
