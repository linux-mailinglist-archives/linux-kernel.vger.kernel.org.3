Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1314557CB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiGUNPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiGUNPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:15:00 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1676F3D5AA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:14:57 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 75so2707374ybf.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEP3AAB/dwBYU2chyIVQ2fqRm+7pu5MqzIYkuw/VKYk=;
        b=G0fLK52jlbcAmWAGHuuh5jj+pTg6u8Uo1hN++1lVcI3UWFo6Dm6PbkHHita0fFwLb8
         OPtiJB3XOB2gGR4PFf29UfsRJVghK0yI7V2+rDF1f4Ivv8BS2bM24IWxtx6SiMqFe2uw
         9qM24/L8h6RYisgNaEbxpFgpyK+NHq0WWAqyVbd+F3EwlSySPP1yqePQFj4Benz8Au0M
         1rPyhn8pIWlMrrJP0WUd1z+RBD9e0kOvkaLSMY4W1Y037Trq7DWRjCi+nziQIt94NWRp
         3aVM/9zSKu/l6Ryo9NhPq3VgvmDWkMVDFYxpSi98rtweSCmvefokfDyf+PMiYrd0Yz9Q
         fRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEP3AAB/dwBYU2chyIVQ2fqRm+7pu5MqzIYkuw/VKYk=;
        b=7BMX+UQF2Bb5iqBnAmyOkzmAK/0znBPq+9YirLhETnuujUC8bzc+N0CcOLSOFucW5U
         8+s0al1q/2n62+mYnUBYGd8+H95Yhpv2XcPyO0kKlng0Gf/EOpSF1p7EcPm9qd3WJDYl
         u1AW5hArVXGpdsRnvTwJl2tvax2Ouynhmh51c7ssJFuYg1a+1y9RQvCL8ezbp+iKmD5p
         4aLa21Bh8hCxAntvI10YadYLd0vzJ5lJLHbMfauPG49JfHAQGIzD0QVAyWKvUQqXEC42
         XqE40dcZaCmgk8ZNKCCTICT+EaCeTX//k2+dQkvrze+OlyW+VZRZ5RNuJ25IKSMR2f1y
         h3Bw==
X-Gm-Message-State: AJIora/3tw2HrZj7OyPki2wgyje1CT3433wd79ZTQ7juaJxB7Vo/QSMt
        umE5n381i3p1Xc6IrDpOKDhl8IzKiaFrhTBXd1WoQQ==
X-Google-Smtp-Source: AGRyM1v0dgWuOsO1tWFKLjX2aUzU29XXliJgzcYmHg43dT+ftWY6TABtvrLenTrDqy2ltXCqMzahYNJLJ6XuKJV4f+Q=
X-Received: by 2002:a5b:8e:0:b0:670:6ba6:5d1e with SMTP id b14-20020a5b008e000000b006706ba65d1emr15093687ybp.138.1658409296104;
 Thu, 21 Jul 2022 06:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com> <20220712231328.5294-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220712231328.5294-6-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 21 Jul 2022 15:14:19 +0200
Message-ID: <CAG_fn=WYUpQguCYoEG7a-GwSZjLzusR+h2iVMLNHvQV9fRQGag@mail.gmail.com>
Subject: Re: [PATCHv5 05/13] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 1:13 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> untagged_addr() is a helper used by the core-mm to strip tag bits and
> get the address to the canonical shape. In only handles userspace
> addresses. The untagging mask is stored in mmu_context and will be set
> on enabling LAM for the process.
>
> The tags must not be included into check whether it's okay to access the
> userspace address.
>
> Strip tags in access_ok().
>
> get_user() and put_user() don't use access_ok(), but check access
> against TASK_SIZE directly in assembly. Strip tags, before calling into
> the assembly helper.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Alexander Potapenko <glider@google.com>
