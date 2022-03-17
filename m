Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C91E4DBC76
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358407AbiCQB3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358384AbiCQB25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:28:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D3E1EEFF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:27:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h13so4822424ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VOxKsTGlBiXPbLWsRjfTqw/sHWeUi1uspD6WChZvBGc=;
        b=LNQndeOSXW/bAWh7JNokNGhZ5eqGvlPxbUsfct7uX8e652+AZTZFl6ZnbKhzWsZnR1
         F98RG8Wz1O2VsVCedS3lzBDewtqbBDLRgtzBBR4D0o7EZvQZNJjxyuAKcQhdfpXgs2kj
         KIIyEkSMSMqcOZyYfIPhbZTyng29T83GGHYU2CJJoH9IK8oJWnuaI8G4WSTUQr7ENP5L
         TNY2t+1Q1U69nlq1sH6hKoMoKg1JCpnaIZSqb3up1G95PvRLagrF6NifKl20EyuOChZ9
         J7dAHfJVKkdxD77XohB1NZlmtuNEsAZkWX2IGX4KCaGAcTbIRASL5NQ6BYDQFt4YerPo
         B6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VOxKsTGlBiXPbLWsRjfTqw/sHWeUi1uspD6WChZvBGc=;
        b=Ihwzew+nh/Y2vrxSdms6jdnFDRk4HSjRZ411gW36Bg4HB6tdh63TjtE6NLc+8F+EtN
         NAJNeYzG3cX33ZOrQDiS2bpvd22ZsdyRMiG6O/wcXizl19BRXEQ0bg9oDxj3KaptCMa+
         JSHNGhszA3AbfxeF1ACL5Tz+6//WRNEnt5L0X97EH37ySW65/3tjnN+12GY2HUomPinQ
         AiD/kZEpNT7o3Ca2helQK6bwz8+v95pON/GG6+MnLZmyBIMwVsXHquCHe/SvZvMTZ1fM
         ili51zO7U3XPYzJN+1OoCta7UQ6jUTkTXcOQCjQqlm8OPnz0F50i756pE45N2P20B6Nt
         kWNg==
X-Gm-Message-State: AOAM533bMWJJf044Y25Ml1m0zjJpgDlJ1NPuzLhalBXQkJXrcrXPWgzy
        mdSBGPOhY3k2WsqvVbXNIWRuapLN+fx54pbm3hZw
X-Google-Smtp-Source: ABdhPJzKzxlZ+0pm3CY5Kl7j8CFXMcoRrP56pFWJh+04iR0sxvt0PPoz+ZQBE4MeZ3T3Tg/mmXPL96Pxy2osfTaCu6E=
X-Received: by 2002:a05:6402:1746:b0:418:d816:14e0 with SMTP id
 v6-20020a056402174600b00418d81614e0mr2016945edx.340.1647480439041; Wed, 16
 Mar 2022 18:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220221212522.320243-1-mic@digikod.net> <20220221212522.320243-11-mic@digikod.net>
In-Reply-To: <20220221212522.320243-11-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Mar 2022 21:27:07 -0400
Message-ID: <CAHC9VhTSTkOLx_CfB9DsG1GqZm87o2Ds0urZv+gS+sA4gMjfFA@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] landlock: Document good practices about
 filesystem policies
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 4:15 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220221212522.320243-11-mic@digikod.net
> ---
>  Documentation/userspace-api/landlock.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Paul Moore <paul@paul-moore.com>


--
paul-moore.com
