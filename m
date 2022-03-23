Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863754E4B06
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbiCWCqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 22:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbiCWCqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:46:08 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C876FA17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:44:40 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id v35so265561ybi.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=efPMQeriJeIkgLVViTGao/zapncCWaiAM0zgGbtLSsw=;
        b=dUM+iDw694EijRSlA098+Fx/aB5+wlja0KvLxv5bOItEnfLDndBOKYUYoL13oP9w4g
         z71UCL+N9Bgbkj4OLZG80dLaXLdvQ67057nb7bCNcm5Mdppy7XkSdb3YH8hGh90jW3Li
         mwsCbtDOrrplqS6Lbd0x1vegri0TaSlKVJX7vhWmSc9GAnyTyA/yF4refuvtMjEYJ9pg
         nezWRQYCQWBY9IgSCAcEaxhGbwuhXI9ZMjLsdNorE79icKTYJaSkuxo4scLBWsDpX8aa
         Ex0UTtiZtAf1M8s6SX1nzjxsN3CAU9cdDZ1ZHBYAn2SFsolUjmtoW3zVUpFGUXgBeKqF
         RlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=efPMQeriJeIkgLVViTGao/zapncCWaiAM0zgGbtLSsw=;
        b=wY3xD/76vHd3s6HiBqSt/l1pHFelz4dDL93/ZpcxNA5Zzc0T9WB7OGsWZjY6sFZCri
         lfMXqI5N9IjeoKP1TKvb2UsFTlcAcYG9Zx1y3UfGTSrdM+fRIBtNJsnlUkSKk7woXtJz
         F28Vwi8YJ7wFIAO71c+638BZZOp2YhF/vdFTCnLf6Aneb0p7RMYIh2zpvZNizOOzBE9S
         BSrIjoCYBiThzM3wRdIcPBzlWY/piyIOwGnK8C/nMwOEP8pJQpYtepx7TwNpGAFlbHf7
         OWynydbm75tG6Q2YQI9PJCeWddkU5Ozzc86j3d9jM2Kk0cSIlBGvmb2Tfe2WZrSsnAEI
         Jq6Q==
X-Gm-Message-State: AOAM5337eqIXM8CXHR65sFCWmRxcERigSq/68zK3sUYrQuMTOS0uC5Ru
        D3FGN/Y5upG/Mx2jziplVrDc/UlnXz0mW7X762TTzCGeV8NRjlSt
X-Google-Smtp-Source: ABdhPJxwzEL+ANDiAAScHbUzhwo9EcOoCzYihDuQY0KTv9hhQV5/TyE+9tWXd4qaAbOMNQ9Xs6c5YTtmK0aUuXcDaDg=
X-Received: by 2002:a25:af41:0:b0:633:905f:9e9b with SMTP id
 c1-20020a25af41000000b00633905f9e9bmr30331661ybj.77.1648003479564; Tue, 22
 Mar 2022 19:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220228094938.32153-1-yaozhenguo1@gmail.com> <CAPcyv4i=1BaEMSJsQWrmPx7ycMTVWXB035xmP8Rc2WEr976Y2w@mail.gmail.com>
In-Reply-To: <CAPcyv4i=1BaEMSJsQWrmPx7ycMTVWXB035xmP8Rc2WEr976Y2w@mail.gmail.com>
From:   Zhenguo Yao <yaozhenguo1@gmail.com>
Date:   Wed, 23 Mar 2022 10:44:28 +0800
Message-ID: <CA+WzARn0St6+oxqnyxBjP0MgzmzBqGX79TvB3A7TAMA5R0Pbbw@mail.gmail.com>
Subject: Re: [PATCH v1] device-dax: Adding match parameter to select which
 driver to match dax devices
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        =?UTF-8?B?5aea5oyv5Zu9?= <yaozhenguo@jd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I thought about it carefully. Indeed, in my scenario(virtual machine which =
use
optane as DRAM), device assignment can be performed in userspace at very
early time after the system is started. This patch is not needed in my
scenario. Thank you for your reply.

Dan Williams <dan.j.williams@intel.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=B8=89 10:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Feb 28, 2022 at 1:50 AM Zhenguo Yao <yaozhenguo1@gmail.com> wrote=
:
> >
> > device_dax driver always match dax devices by default. The other
> > drivers only match devices by dax_id. There are situations which
> > need kmem drvier match all the dax device at boot time. So
> > adding a parameter to support this function.
>
> What are the situations that happen at boot time that can't wait for
> initramfs or userspace to move the device assignment?
