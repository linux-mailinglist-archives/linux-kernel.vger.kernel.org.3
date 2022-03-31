Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38C94ED744
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiCaJv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiCaJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:51:27 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5F6201692
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:49:40 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id z8so24713231oix.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tky9nCrv81M6G9Z2TVrn5hOhzmobZGWqlkFMKY0mDOw=;
        b=AG7DBUa08iP0woyYFdUxmbVMIORrfhtAkW7JN06b8er7H4a1ZY3DSttHZp6UuNPbkC
         qeMpUs/Z2a958YZZW0D/7Rb1UHj7xdZ1XyHI4pewEyWJW2l6zZmDJ6QaMhK5EhCWhk4m
         W3bzSJJ40soARswxFyL8ZTcQK8JUSq2wScAO4+CGrK/q+VTdbwvTg7B1LgY64ndp5zde
         eYV4nK9ukPGYbAL6DF//oY0jOB7g1ANKibEFmJbs0D9AGiaWD5LdFcZH8HEsYchsEkPe
         P7skTdYunRIMoKcnTtR7hNQUMw/V+jf91cl7ezRfFYGpMW5VgQZYnhF1wIYFvi4GX+KP
         Zfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tky9nCrv81M6G9Z2TVrn5hOhzmobZGWqlkFMKY0mDOw=;
        b=0z7NSzRVFwqDISVt+LWp2AWB7d/mbA2aq2aetGJOunGI1HYE84szzAgSF4M/qupy88
         EyjSvjZEQgIvfJ7xlKI+PWk5Q/3FdjdA1cKXd0muwHNnSR89Nur2N7njNC+24xnFVM5l
         /2ZCmcHHxAxSVcafkpx0TPbsIYKhMrPvyOeCNZSx2EInQXnBI0GVP0vNl8ZCQjeLxCs+
         Wbznnp8Cdcwi8WQCscy7+CD55czJIab69emcn/pLyzlJEWz+RtmuieY12+2kUyXrSFwK
         mkIxPA+WOgOZ7nGcZDRAM7Qnf/NU467qKvfDoM9QXIAGWUJ09TknAcqag422DTmLhYED
         JbZw==
X-Gm-Message-State: AOAM530oqxvAOkmEMWqRwEvUx6TCEyOcIPVZDAiBfIYbaVfJY/txC8+/
        kpLJYEtGC0AjctXtFxy98BodIv2cv55aoorW14A=
X-Google-Smtp-Source: ABdhPJwZjuzJyRuaqnhd3zKRy3O7110Yi1h28qdzRzl2L4b03KiYmch1UHPuMdTiypa03sFsx4XE1QJcpln5bw5CAs0=
X-Received: by 2002:a05:6808:1709:b0:2f9:30ec:c95b with SMTP id
 bc9-20020a056808170900b002f930ecc95bmr2132102oib.240.1648720180328; Thu, 31
 Mar 2022 02:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220330110715.GA1534@raspberrypi> <YkVT3z4ksYStau85@shell.armlinux.org.uk>
In-Reply-To: <YkVT3z4ksYStau85@shell.armlinux.org.uk>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Thu, 31 Mar 2022 18:49:29 +0900
Message-ID: <CADLLry4EKn+EqqaM64Hi0ooPJotMX8HekLafsgEjSxSPvOK2wQ@mail.gmail.com>
Subject: Re: [PATCH] arm: kdump: add invalid value check for 'crashkernel='
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>,
        Paran Lee <p4ranlee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022=EB=85=84 3=EC=9B=94 31=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 4:10, R=
ussell King (Oracle) <linux@armlinux.org.uk>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> On Wed, Mar 30, 2022 at 12:07:15PM +0100, Austin Kim wrote:
> > From: Austin Kim <austin.kim@lge.com>
> >
> > Add invalid value check expression when no crashkernel=3D or invalid va=
lue
> > specified using kdump.
>
> Hi,
>
> I think you mean when "crashkernel=3D0" is specified, as other invalid
> input should result in -EINVAL being returned. Please update the
> patch description and comment.

Thanks for feedback.
Let me resend the patch with updated commit description and comment soon.

BR,
Austin Kim

>
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
