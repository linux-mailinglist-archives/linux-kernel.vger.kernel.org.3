Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C65154D1B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347911AbiFOTfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347369AbiFOTfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:35:14 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928F1340D1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:35:11 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y29so14409189ljd.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sD8IqB97I70LoLibTMokNd39/3wgDdyCaZhezBKenf0=;
        b=DyKH3kucgWByYnRSwlcv/ad2v9o/FLycAER5k5b3kHFwFUzuAEgM23y4XArIqyzH/V
         YTF9V80+outxXkkLFijzi+R+8GJYb515k3NH5VTRI5wUqc+/6nfYqtPy7VvQG88ylx82
         DcDdtvG3cCEBeDOtI8QnddDLFhP+34VHvs/p1PCc+D7YfBYqTZyWdvi87+axb2jxAA/V
         Cp690LwLvz6+qpkvDid858R6u5J39vw/uN0/uY1QMq6euonnAErJN2p8wiUoo2aQEUu0
         OofPnvvA+7VrlGlep8QvvPrBzZXFa8ugfSNgo91+BJOqHjnfpf+RzCSPsVuUGLEKBgrh
         YgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sD8IqB97I70LoLibTMokNd39/3wgDdyCaZhezBKenf0=;
        b=JaxbkJ498318BZBJWvJVquanbFtWvmGQCIl6iNvU4HryzU01nXEFFn4HuX4ycvWYiT
         Ia9CjRPi9OUlbiItHFNTQ6vG3/2nCmKCoiLwDENLpb5RvSZQ4tTb0WKQuJE5T3aOPhKC
         5lxrvdkbsmnAl6SKaXSd9Bbh/WoP8T4TTP/KfdHdBe1VuxsfBnlwXKg7or1YoV+VghcE
         qxqlKPcAtIF0xzbFLF+rL6Ih1OzrG4oQLzxIe1fLhqgDlVuPr+k2CpR5kWeZQY1ib2uM
         pOlnfz+oHqZE8AzbybNEs9OjTKANDDmLO4F4KC2jcISfQkp+VsqCEXl7nhCFW1Jalvnq
         U+fQ==
X-Gm-Message-State: AJIora9mkbTLKYzkWbup8GCwF9k12YaBM0/iC3oowAdOXnTcmp0ZAxrW
        14h2B0yTXI09TgAW3D8sJxnsQ6EP1BjWnU4U3TM=
X-Google-Smtp-Source: AGRyM1sWxw7zY1g4d0407a5YHUWym6xAHli3VBmZQqGYIY+b5c8KMHy0x1k5bXN8j9IAxZwjGPXjwFnDf4WDXVkzER4=
X-Received: by 2002:a05:651c:a04:b0:255:bf2e:72b9 with SMTP id
 k4-20020a05651c0a0400b00255bf2e72b9mr686193ljq.333.1655321709803; Wed, 15 Jun
 2022 12:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220614210217.1940563-1-martin.fernandez@eclypsium.com> <20220615190519.GA1524500@alison-desk>
In-Reply-To: <20220615190519.GA1524500@alison-desk>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Wed, 15 Jun 2022 20:34:58 +0100
Message-ID: <CAD2FfiGxy=9ARK5FT_iaLACZSzR+R4crmGJv7T+v_w3+ktOzCQ@mail.gmail.com>
Subject: Re: [PATCH] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, daniel.gutson@eclypsium.com,
        alex.bazhaniuk@eclypsium.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 at 20:06, Alison Schofield
<alison.schofield@intel.com> wrote:
> My first reaction is lying about the cpuinfo is not a soln, since
> it creates a problem for a users currently relying on cpuinfo to be
> the source of truth for TME.

I think you have to qualify "source of truth". At the moment the CPU
reports "Yes! I support TME!" and then for one reason or another the
platform turns it off and actually there's no memory encryption of
your secrets at all. There's seemingly no userspace way of telling if
TME is actually active. We were told that we shouldn't export the
"platform has disabled a CPU feature" in sysfs and just to clear the
cpuid flag that gets exported (like AMD is currently doing) which is
what Martin proposed here. Programs want to know the true CPU
capability can do __get_cpuid_count() like they can for the SME/SEV
capabilities.

> Are we to tell them to go look in the
> log now, because fwupd folks didn't want to ;)

We're not telling anyone to use the log; grepping megabytes of
unformatted kernel logs is a terrible (and slow) way to get one
boolean value.

Richard.
