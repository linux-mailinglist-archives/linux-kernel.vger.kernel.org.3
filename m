Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED45613BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiF3Hy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiF3Hy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:54:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0A83EF09
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:54:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so1105412wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/SAO6yxGxm5Sd9hDugM5MgbWtMqhIwdy90KEBsNaNc=;
        b=qeA/V/oWeomJqjBRyK91b1z2O3v+gRJo7zqwxOTHQaer8BghiE8SwOxOl2eJrUz5J5
         6RwBHTk5PpYOaHi+B2pnt3X9OTUrrGIpqJ44PFROMzT/usE3wuHeB91Rcouv0eG3G2aO
         v7LRlo55ffDHHEjAYdILFk4JpTiQPxjXuLHx99L8MArDnMJB1RAh/vEsZB1TRBBna2Ic
         Bq2o+uyoo6w/NuswkUoQiC2ycGZYrjCxnw/07dNVQxoOHtNwBJsT4nL+djFyuCibBaqp
         uv1+i+NWTbGgwmLatF08xxnfavun7ouZmY0qLoOEBlkT6V+5XUP4AMhV4CMnJQA80wgF
         Fuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/SAO6yxGxm5Sd9hDugM5MgbWtMqhIwdy90KEBsNaNc=;
        b=I65KF61f0TEokVRtnot3fIeYSlgtrTIosy1sG6YRnZJUhMtCZaIl1gxFikVP/1dyvp
         QnghBBDpY4kXzYDTGf2xblXouBFeUIEaSu9CbkeixtwAzMyyE3in1M5MMwC7Ri+vYrD/
         NJezZkv2lBRO0d6C7GWaFao8IPtwWBIxPerTPg8bVl2w9Ku8iSSHFrc90nXp4ErdeM9f
         7C4DLs1TZBWsbUXVRecUp7SOOS10+/qPOYEhkziAgjO+fzoTkjei/emkuiI/o0h/B/0z
         AHt+i0FwhEg3b11ZNZo6i7ukrNSOUoB4zHLGtR+XIpzP2kNut0v6er5Gzec+kcbdYZ9x
         zbcA==
X-Gm-Message-State: AJIora+Ew9S/Lx0VuZiEQaGX0h+AhG7y87iWlApjMJHv3QBSr8uNdwlQ
        Gtztmx1DUIOxZqp3+SeEPjMEVZH8lUObomwnVSVyEQ==
X-Google-Smtp-Source: AGRyM1u4Yz3S88wzcuyM6lBzJeuA3mFwVMcgqw9eViPyPNjcdd4aCWT2gWIzK3iJEJcxS2Yr+/F4iMvUgoJToCW4SP4=
X-Received: by 2002:a05:600c:4fd0:b0:39c:6565:31a5 with SMTP id
 o16-20020a05600c4fd000b0039c656531a5mr10297511wmq.60.1656575663609; Thu, 30
 Jun 2022 00:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220527185600.1236769-1-davidgow@google.com> <20220527185600.1236769-2-davidgow@google.com>
 <CA+fCnZe63vugPRbD3fVNGnTWbSvjd08g8coG3D71-=NtqpjOvQ@mail.gmail.com>
In-Reply-To: <CA+fCnZe63vugPRbD3fVNGnTWbSvjd08g8coG3D71-=NtqpjOvQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 30 Jun 2022 15:54:12 +0800
Message-ID: <CABVgOS=hW0Paz2EwV0dvJQLM9cT-YNBzEXmUJZZ8Db5PZr-5Qg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] UML: add support for KASAN under x86_64
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ff213d05e2a59349"
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

--000000000000ff213d05e2a59349
Content-Type: text/plain; charset="UTF-8"

On Tue, May 31, 2022 at 2:03 AM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Fri, May 27, 2022 at 8:56 PM David Gow <davidgow@google.com> wrote:
> >
> > From: Patricia Alfonso <trishalfonso@google.com>
> >
> > Make KASAN run on User Mode Linux on x86_64.
> >
> > The UML-specific KASAN initializer uses mmap to map the roughly 2.25TB
> > of shadow memory to the location defined by KASAN_SHADOW_OFFSET.
> > kasan_init() utilizes constructors to initialize KASAN before main().
> >
> > The location of the KASAN shadow memory, starting at
> > KASAN_SHADOW_OFFSET, can be configured using the KASAN_SHADOW_OFFSET
> > option. UML uses roughly 18TB of address space, and KASAN requires 1/8th
> > of this. The default location of this offset is 0x100000000000, which
> > keeps it out-of-the-way even on UML setups with more "physical" memory.
> >
> > For low-memory setups, 0x7fff8000 can be used instead, which fits in an
> > immediate and is therefore faster, as suggested by Dmitry Vyukov. There
> > is usually enough free space at this location; however, it is a config
> > option so that it can be easily changed if needed.
> >
> > Note that, unlike KASAN on other architectures, vmalloc allocations
> > still use the shadow memory allocated upfront, rather than allocating
> > and free-ing it per-vmalloc allocation.
> >
> > Also note that, while UML supports both KASAN in inline mode
> > (CONFIG_KASAN_INLINE) and static linking (CONFIG_STATIC_LINK), it does
> > not support both at the same time.
> >
> > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > Co-developed-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Hi David,
>
> Thanks for working on this!
>
> > diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> > index a4f07de21771..c993d99116f2 100644
> > --- a/mm/kasan/shadow.c
> > +++ b/mm/kasan/shadow.c
> > @@ -295,9 +295,29 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
> >                 return 0;
> >
> >         shadow_start = (unsigned long)kasan_mem_to_shadow((void *)addr);
> > -       shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
> >         shadow_end = (unsigned long)kasan_mem_to_shadow((void *)addr + size);
> > -       shadow_end = ALIGN(shadow_end, PAGE_SIZE);
> > +
> > +       /*
> > +        * User Mode Linux maps enough shadow memory for all of physical memory
> > +        * at boot, so doesn't need to allocate more on vmalloc, just clear it.
>
> Should this say "for all of _virtual_ memory"?
>
> Otherwise, this is confusing. All KASAN-enabled architectures map
> shadow for physical memory. And they still need map shadow for
> vmalloc() separately. This is what kasan_populate_vmalloc() is for.
>

Yup, this was a mistake on my part: the original RFC for KASAN/UML
only allocated enough shadow memory to cover physical memory, but it
was changed in v1 (which I'd forgotten).

I've updated the comment in v3:
https://lore.kernel.org/lkml/20220630074757.2739000-2-davidgow@google.com/

> > +        *
> > +        * If another architecture chooses to go down the same path, we should
> > +        * replace this check for CONFIG_UML with something more generic, such
> > +        * as:
> > +        * - A CONFIG_KASAN_NO_SHADOW_ALLOC option, which architectures could set
> > +        * - or, a way of having architecture-specific versions of these vmalloc
> > +        *   and module shadow memory allocation options.
>
> I think this part above and the first sentence below belong to the
> commit changelog, not to a comment.
>

While I think there's _some_ sense in leaving this in the comment (as
a bit of a reminder / TODO), given that the commit changelog is more
ephemeral, I've moved it to the commit message for v3. This will be
easy to find via git blame, while not cluttering the actual file, so
seems an okay spot for it.

Cheers,
-- David



> > +        *
> > +        * For the time being, though, this check works. The remaining CONFIG_UML
> > +        * checks in this file exist for the same reason.
> > +        */
> > +       if (IS_ENABLED(CONFIG_UML)) {
> > +               __memset((void *)shadow_start, KASAN_VMALLOC_INVALID, shadow_end - shadow_start);
> > +               return 0;
> > +       }
> > +
> > +       shadow_start = PAGE_ALIGN_DOWN(shadow_start);
> > +       shadow_end = PAGE_ALIGN(shadow_end);
> >
> >         ret = apply_to_page_range(&init_mm, shadow_start,
> >                                   shadow_end - shadow_start,
> > @@ -466,6 +486,10 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
> >
> >         if (shadow_end > shadow_start) {
> >                 size = shadow_end - shadow_start;
> > +               if (IS_ENABLED(CONFIG_UML)) {
> > +                       __memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
> > +                       return;
> > +               }
> >                 apply_to_existing_page_range(&init_mm,
> >                                              (unsigned long)shadow_start,
> >                                              size, kasan_depopulate_vmalloc_pte,
> > @@ -531,6 +555,11 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
> >         if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
> >                 return -EINVAL;
> >
> > +       if (IS_ENABLED(CONFIG_UML)) {
> > +               __memset((void *)shadow_start, KASAN_SHADOW_INIT, shadow_size);
> > +               return 0;
> > +       }
> > +
> >         ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
> >                         shadow_start + shadow_size,
> >                         GFP_KERNEL,
> > @@ -554,6 +583,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
> >
> >  void kasan_free_module_shadow(const struct vm_struct *vm)
> >  {
> > +       if (IS_ENABLED(CONFIG_UML))
> > +               return;
> > +
> >         if (vm->flags & VM_KASAN)
> >                 vfree(kasan_mem_to_shadow(vm->addr));
> >  }
> > --
> > 2.36.1.124.g0e6072fb45-goog
> >
>
> Thanks!

--000000000000ff213d05e2a59349
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA8
dJASzRdZfOM9mtHBhqflP7aBrs0/xvVtIUdMC3r85DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA2MzAwNzU0MjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAYakGfvHtyZ4mETpJfNlS
njRUqpN1/M/fQW/N1GCxRQqh/L56zkSnqSGAmJgSpYO5ZAKXMLyzMybVDqz/KV06EuuDObU0ASGf
NpnEUXAPEb8Z3Lw1b0vhGfzBpI/VLS+9tCJ+aiY6VruXKZzs12fdGctTJQyvoUDgAVdEurtrlITa
ZNMiqQMQ9oTdUCDY0Hjn33WAehp1wX2zm87b5yaLFvT3dNpoTUOc9I73wBwJHJldacAzY+sRsRHF
JkFIz5S3tn7SypCbsfHfxpmiLjwnbvAID3xdaYMVh5B1o5caNzVe/uQqLP9pTvRPUtYy1Y6qBiKs
w0Hn+2N9k/Ht945f8Q==
--000000000000ff213d05e2a59349--
