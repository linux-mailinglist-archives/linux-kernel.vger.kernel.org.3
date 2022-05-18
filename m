Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EDF52C26C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbiERS3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbiERS3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:29:02 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1024205241
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:29:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id a38so23767pgl.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rs+hYjREIGQRrA6fYOwB+iDuVdssLJ9+QtiHFV7DjL0=;
        b=56li6rLC4mQzRo0A2kXqCOMihPnh37A1HauoHxo4CjJMMuRdOwMf25S0Gg0mhW4H1V
         9oOovgGOyX26iKhdSLr17ZDHUilwvfRWItX4kYjWxDcZeJLKtWZdFg1s7NiWZdD+GyVM
         KJttKiC4l1M5erBf0kwMAuhlpCYSJef4Ht1zQqWzfQh9U259WzwAbZy7OglBSEw1Kkt5
         I8zIKarbcikHCK0RFMumk20d6U4SinIwA/pHFrpQj3jVTbbDOPe4Z+fN1BJJD+DxEI+B
         O7cWYnGGR+LQ4+Smr495r3EMtIZ9/Hrn5EVFhO1s214IbW9ifIzL2RKvXS2XHrYOVgOA
         InyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rs+hYjREIGQRrA6fYOwB+iDuVdssLJ9+QtiHFV7DjL0=;
        b=Oj3XBD01MWaL4w5+awgpQA0uIveY52GpqFJ640Y9qs8Div6lBtiZpPXuJMJHajvIL3
         IX2PHu6i1hivRdHiP/ruiGH7TlCELSnDA2GEhCYfw7wID24a6AVL9gOv5Y76WNlXgh91
         drSUobGdXo8QDvF5byr94TcdC30lYi0ttVjZTaIlSrSEGnf4cxs2rWpn4TLyvuSHhZTr
         jRXt5o0pbQWrHK1ZmQ2jj7kQCTGydTcm6RrNwTBJC9e5g0TClEW19GiHn9rRJ4bza3YG
         v8ia8MZjF5UGENEZVaEOWo5PJdOAcBTNnpex9/0eu9rxjRCH5Ys4rtDNvmN3I5zhmY2P
         JUVw==
X-Gm-Message-State: AOAM532EgD6KZpITCXy8rK3IYIgw9N31Qq8IL2tgzQtFXE3jT/yFJ8uR
        w4yPGWruk3rIRdzY3PsKkRrjgAtj7npzwYHARbNXBw==
X-Google-Smtp-Source: ABdhPJwMwJen2kHUljMxLGhfJo+EhmxX/T4W59DWfSThgOD6IYw6SPZuTRmwpc9boSVZhrVVAKPtxD2J9ln9cKQkELQ=
X-Received: by 2002:a63:e648:0:b0:3f2:7ade:8f86 with SMTP id
 p8-20020a63e648000000b003f27ade8f86mr670271pgj.40.1652898540353; Wed, 18 May
 2022 11:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com>
 <YnUYLDjIThbIz/Uf@zn.tnic> <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com>
 <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com>
 <47140A56-D3F8-4292-B355-5F92E3BA9F67@alien8.de> <6abea873-52a2-f506-b21b-4b567bee1874@intel.com>
 <FDABC5C8-B80A-4977-9F97-5A8FC47F69D6@alien8.de> <4bc56567-e2ce-40ec-19ab-349c8de8d969@intel.com>
 <CE52D65A-C9F4-408D-B18A-72D87495A433@alien8.de> <CAD2FfiHe3hCSNHEA0mSWPbH4LEWhj+FgxkhO83U1GgYEJR6wrw@mail.gmail.com>
 <YoSlzqSGLrQ+jdnD@zn.tnic>
In-Reply-To: <YoSlzqSGLrQ+jdnD@zn.tnic>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 May 2022 11:28:49 -0700
Message-ID: <CAPcyv4jv52nv=Q=gm783ysU8D56iHzh9-UJrqqkgUve0f_kyZw@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able to do encryption
To:     Borislav Petkov <bp@alien8.de>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        "H. Peter Anvin" <hpa@zytor.com>, daniel.gutson@eclypsium.com,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, X86 ML <x86@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        alex.bazhaniuk@eclypsium.com, Greg KH <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 12:53 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, May 16, 2022 at 09:39:06AM +0100, Richard Hughes wrote:
> > This is still something consumers need; at the moment users have no
> > idea if data is *actually* being encrypted.
>
> As it was already pointed out - that's in /proc/cpuinfo.

For TME you still need to compare it against the EFI memory map as
there are exclusion ranges for things like persistent memory. Given
that persistent memory can be forced into volatile "System RAM"
operation by various command line options and driver overrides, you
need to at least trim the assumptions of what is encrypted to the
default "conventional memory" conveyed by platform firmware / BIOS.
