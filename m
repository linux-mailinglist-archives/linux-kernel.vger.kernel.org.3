Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67275613BD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiF3Hxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiF3Hxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:53:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562BF2AE3D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:53:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id s1so25961216wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPenx2DEXVp18KG97S9VeM/W6b6px6tnzzbH3qfsGBI=;
        b=SQDAD9XwZspvRxeNfsr+pOjUoNApFavriP5lapR9p2Ytufz+05CiLOcpYQOrIwA2T4
         bWrv3Z0aO+YAU9gJU1cWv9jnqNAdBQ44LibyoE1W1Q4dRb9RhiIk8ETVo++RvRGVfy3l
         7XlMrRPqB0F2X6JlAjVMi6hLIc/YR1AnP96CzG0qXtJ+nnfmiy1xbdo+nn6/Wpo+WfMJ
         +hTqLK21nwuFGLeEn5loxiAQx1dkGrvJWKmusVNidWZWrtgs+4jMAUI8Aw3U+YeGqRGY
         dzBDqK+jDWZlLj2uVOzMWVkB6/OId1+b63ddeiofvnG/zRCrYH1073k3QVbpNuG4Qsra
         EF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPenx2DEXVp18KG97S9VeM/W6b6px6tnzzbH3qfsGBI=;
        b=aj+iFrSeyh60VBuJxpENr+nxZipose6kDv7U3qg+t83JCrDrcBiFmAAERWOVgjLi00
         mCxFEoUhPMLWeiLK94lr7NuMEAqUhqNuBRcEwFZwlaRimYuaEyldeXIJMm4mmGMITM+K
         11LX7EHZWi6M6Cmb4xjx2wmioH34vNdZyarIcIas3iEE8y/MtUElgq28m61Zpa5DcpNI
         jg6JE/BfCew9b0NdVB1Vf+tM8aZUhHv95KbL+UslR5KpjLpftUngTG9hWlXvkrcHO4ty
         JssgO8jnLw20EI1lPgifCEWVv1i5xLXOLh2Yl2YadVNhFkBYn4mLx18AEhLxtGQ33NID
         5vaw==
X-Gm-Message-State: AJIora+JiRsiccBb+dSXWleZdtz2+f3Wn66/dioWTwSXoL/SsgwXRiUT
        Oloo1tj9ekJl1j0l3yh0D0DXstF8OQMzf44AsRimMQ==
X-Google-Smtp-Source: AGRyM1sFu6yMoj8iphHnn+f9xiaAyERbOcFEQNh+38d+dpJ4eBv3sIUAfUZzCGXrE2kR90H8/EDkuQI0PGZvOsSnQpc=
X-Received: by 2002:a05:6000:144d:b0:21b:b3cc:162e with SMTP id
 v13-20020a056000144d00b0021bb3cc162emr7099100wrx.433.1656575613798; Thu, 30
 Jun 2022 00:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220527185600.1236769-1-davidgow@google.com> <20220527185600.1236769-2-davidgow@google.com>
 <1a4e51a4d2ed51e7ae1ff55bd4da6a47fad7c0bf.camel@sipsolutions.net>
In-Reply-To: <1a4e51a4d2ed51e7ae1ff55bd4da6a47fad7c0bf.camel@sipsolutions.net>
From:   David Gow <davidgow@google.com>
Date:   Thu, 30 Jun 2022 15:53:22 +0800
Message-ID: <CABVgOSmcwGa4tw8EvuxbeOvrTLh8d7V3mFxGyj2spnqqWkFp9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000005a63405e2a59168"
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

--00000000000005a63405e2a59168
Content-Type: text/plain; charset="UTF-8"

On Mon, May 30, 2022 at 1:04 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Fri, 2022-05-27 at 11:56 -0700, David Gow wrote:
> >
> > The UML-specific KASAN initializer uses mmap to map the roughly 2.25TB
>
> You say 2.25TB here, and
>
> > +config KASAN_SHADOW_OFFSET
> > +     hex
> > +     depends on KASAN
> > +     default 0x100000000000
> > +     help
> > +       This is the offset at which the ~2.25TB of shadow memory is
>
> here too, of course.
>
> But I notice that I get ~16TB address space use when running,
>
> > +/* used in kasan_mem_to_shadow to divide by 8 */
> > +#define KASAN_SHADOW_SCALE_SHIFT 3
> > +
> > +#ifdef CONFIG_X86_64
> > +#define KASAN_HOST_USER_SPACE_END_ADDR 0x00007fffffffffffUL
> > +/* KASAN_SHADOW_SIZE is the size of total address space divided by 8 */
> > +#define KASAN_SHADOW_SIZE ((KASAN_HOST_USER_SPACE_END_ADDR + 1) >> \
> > +                     KASAN_SHADOW_SCALE_SHIFT)
>
> because this ends up being 0x100000000000, i.e. 16 TiB.
>
> Is that intentional? Was something missed? Maybe
> KASAN_HOST_USER_SPACE_END_ADDR was too big?
>
> It doesn't really matter, but I guess then the documentation should be
> updated.

Whoops, the amount of shadow memory allocated was changed for v1 of
this patch (it was ~2.25 TB in the original RFC). I've updated these
comments in v3:
https://lore.kernel.org/lkml/20220630074757.2739000-2-davidgow@google.com/

-- David

--00000000000005a63405e2a59168
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAC
4kJdF+2X25TeKcgcUQweuNOfKBGXpRPTwPX85b92ATAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA2MzAwNzUzMzRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAFOq49C9C+/7jAbmXMpO+
lVoTeO5gA2h71wuh4Nu4Km6zxPF0/b55zj3dQmxiACPcxvEI6GVlR6zOF5icVoQP51kMwn1X2mOx
hi6LROmQBljVaF33H+y2JVvlpIAJ+AzBv4vx9HxozNc7w2H4Rs0FVsrQZ7+r/ymZL1USwDMiinuV
5vJyGjoPbAG3SMmuufGU9qpp4ly8LtN+x/g9uVSTnDSGB/D47pbqKQzDo5t8ZwyngmN6Jkyn4SIi
+g75XK5RwkV97ESUsRyxIaW0EMEhoWXM6VFihvYUbrz1UcDLwR3MC06ifTgEyUvcK5e9COb3Dp0m
Ik2JTZrTnHoanWgcgg==
--00000000000005a63405e2a59168--
