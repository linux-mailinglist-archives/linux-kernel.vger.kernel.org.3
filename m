Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF8F57DAA7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiGVHMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiGVHMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:12:36 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00C68E6D9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:12:35 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id t127so3581116vsb.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJkZzeVVeqhbCaOr3UHCo90jJ8JW+y4qvEiv5AJYV5g=;
        b=mPi+BYZsM370KV1+AJ253wEcfMvB/dbaoY94gEfN2i23iwUpsQ+MSu2Q0Sk0MfhYhs
         aAqTzv15IWOkI+Er1x0QmYqaf1X+PMWOqFqqrAkve/mYKnwkR+336EqLnZ8n1mrIdGD1
         zQ11Vjbl8XBCe5U9gGYiq/oay0+N7WD3FNMJHFhGDkXqpLZ1ra8Y/OlX+9Imn6m24d59
         Ab6EJj88QIMb9e5b9Sb2FmdwFciCLUQKx+4A4lcQaPiRiluAwivw5I/HmYaEGQXWqY9M
         QvTM6mJ9gZFI3lsivTIZ7AC9ySe616sbw7T0xqQfZn5EiEDNTwFNFD+Q3nIIMua+GCvm
         R6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJkZzeVVeqhbCaOr3UHCo90jJ8JW+y4qvEiv5AJYV5g=;
        b=McnqSwHn9RkNJSK/QA0AON4VRKwAvrCHlKK8ZieHItXGmxUTmfwkRVMLm9D12jpjwc
         6RPMZ6pAxM398IU0nrxNILpJtgYpxRkriTB34eoD/O7DfGs+DaB0AL9MiPFla4ICukeM
         iaX19NcDi7+RX9CVKKmCRmyDC3dXqNdH5L5kiRrLCm9Une1onBHVjeTat8TMoXUsNxO+
         n3KF4aslih6p3EgdVQuvbUhmGnPTrAjEOV024n4+uMrHbAR6CFHzzqC/BQJJzlia7ZS0
         47uMi/3NDVPfFe/uigej2EtnVN0aToEiXuGcDXpVvQt1FSXNpJWa/pscTZecMEln2O0/
         WVRw==
X-Gm-Message-State: AJIora8B4JPAxuJxXqSRgBly93rkKUlq/7I/jPKQKRSd1B2ddxuaDVVG
        zWbsVSpe8qAEgYwU30WJQVsph2KeaEFV1pNC9UQC/cU8dD4=
X-Google-Smtp-Source: AGRyM1tuOGn73TS9hgd/PmlURX4CDi++p6g/fvA0RBMMzEPeVR6kLiAvCKt6grhdA94W0CcN677tGOl+QyZL3X6vKhU=
X-Received: by 2002:a67:c895:0:b0:357:48d2:fa1 with SMTP id
 v21-20020a67c895000000b0035748d20fa1mr659259vsk.22.1658473954680; Fri, 22 Jul
 2022 00:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220721180214.3223778-1-dlatypov@google.com> <20220721180214.3223778-2-dlatypov@google.com>
In-Reply-To: <20220721180214.3223778-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 Jul 2022 15:12:23 +0800
Message-ID: <CABVgOSn7-H63BDDQcsZ-c3ZWDCSrP43uY5eYsqG+w2LEGJqODw@mail.gmail.com>
Subject: Re: [PATCH 2/4] kunit: drop test pointer in string_stream_fragment
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f49da805e45f8e5e"
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

--000000000000f49da805e45f8e5e
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 22, 2022 at 2:02 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> We already store the `struct kunit *test` in the string_stream object
> itself, so we need don't need to store a copy of this pointer in every
> fragment in the stream.
>
> Drop it, getting string_stream_fragment down the bare minimum: a
> list_head and the `char *` with the actual fragment.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Yup, this is definitely redundant now. Thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/string-stream.c | 10 +++++-----
>  lib/kunit/string-stream.h |  1 -
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index a2496abef152..f5ae79c37400 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -22,7 +22,6 @@ static struct string_stream_fragment *alloc_string_stream_fragment(
>         if (!frag)
>                 return ERR_PTR(-ENOMEM);
>
> -       frag->test = test;
>         frag->fragment = kunit_kmalloc(test, len, gfp);
>         if (!frag->fragment)
>                 return ERR_PTR(-ENOMEM);
> @@ -30,11 +29,12 @@ static struct string_stream_fragment *alloc_string_stream_fragment(
>         return frag;
>  }
>
> -static void string_stream_fragment_destroy(struct string_stream_fragment *frag)
> +static void string_stream_fragment_destroy(struct kunit *test,
> +                                          struct string_stream_fragment *frag)
>  {
>         list_del(&frag->node);
> -       kunit_kfree(frag->test, frag->fragment);
> -       kunit_kfree(frag->test, frag);
> +       kunit_kfree(test, frag->fragment);
> +       kunit_kfree(test, frag);
>  }
>
>  int string_stream_vadd(struct string_stream *stream,
> @@ -89,7 +89,7 @@ static void string_stream_clear(struct string_stream *stream)
>                                  frag_container_safe,
>                                  &stream->fragments,
>                                  node) {
> -               string_stream_fragment_destroy(frag_container);
> +               string_stream_fragment_destroy(stream->test, frag_container);
>         }
>         stream->length = 0;
>         spin_unlock(&stream->lock);
> diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
> index 494dee0f24bd..b669f9a75a94 100644
> --- a/lib/kunit/string-stream.h
> +++ b/lib/kunit/string-stream.h
> @@ -14,7 +14,6 @@
>  #include <linux/stdarg.h>
>
>  struct string_stream_fragment {
> -       struct kunit *test;
>         struct list_head node;
>         char *fragment;
>  };
> --
> 2.37.1.359.gd136c6c3e2-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220721180214.3223778-2-dlatypov%40google.com.

--000000000000f49da805e45f8e5e
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBe
fLSrtwN9RIXQTFYP1nJAuOL69zkcDRqkrdmPyTqEnDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MjIwNzEyMzRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAB3n5tl096euRhCBULdmJ
rGIC7Sj1XYeHZi7tQt5LDGocuBeI+i5Lf0PhUbfNGrg6NvmzXwHm2y+uo5JeC5KBMM/RH8OHiv0U
IEtL/plF1SyuLrzZUYWTwoa+BkWVqS3op5MWWy9p6OgS+XJ0cnjdU4S9YiW+q2cqPzypP+l/7ZSu
3CEtcnEkMGyamBQLjmUODe79xRsAORu5pY+SYpRUM/2D1AcdcSkrTqQg942fFPfwOTheeGuwDlH6
uta3mp3kzoBtA5QiSce89e3Vkpl4wtZleNdORfKwW5kWnjCGrc2wKTI84JjnBZEmOw8uek6EMvhO
S7AdZOzUKyqOpFPbYQ==
--000000000000f49da805e45f8e5e--
