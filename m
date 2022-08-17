Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96039596845
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 06:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiHQEnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 00:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiHQEnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 00:43:35 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8E31147B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:43:33 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id d126so12117089vsd.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UxCmLPJnsy9sW4BgZWiuWXobqIm0nq94OfYsaOLOldU=;
        b=tfe8pk3jgg6s5AUs4Z2PqKm6+n5bs5+pGnozkGgkRolavosZDex+zNX2z8SB1bGmcF
         lvmQ52f5BL6aL5S1XnfbKpNijaM6PkLRxgaHbvsYj/THWM6/eW3HMtVpfsRvLT8CHNSs
         n3n0xZstV37XBQWy032I+1OH3e7/QUQVBYdXh99NywztQE9InCAX55DHQqKmLw1tRh7a
         sjBJUmvUSOshiznTKzgdkbStxDypV8uJwjqGl4wIQLOw3OAR/7ERGymcnQpoSgl4c8g5
         seYp1o8qS4MnEryV0Ux/j0RwbbPQdZMlbrNmulhTnLjhnJDurhSRE+DYomhGb5K2htRc
         I7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UxCmLPJnsy9sW4BgZWiuWXobqIm0nq94OfYsaOLOldU=;
        b=fBf1lmpRHvxs12jo/9te/a2n+v8MOcJbTxbG4nPtBtsBHiangGqkc4jMKZ9/+FV8aW
         vzh8hSA/aZLAzHg+5KTc/fRpAbkxK627Kovix37Ml5SI/QHb4DHAZn62sXlUjWIpxtgv
         bH9Ska56jB3N/yKdh2lpNKxSoj220wZMHMNZReutGROGSh/y6pkZCm/5yCKsOTE6j+/w
         Dfhtyl1hQGmQffw5uwrrfpGDDPh/k02OYQZXm7A5DnlMzdrbH5sQpcmIUoIs7C2RPfgY
         pQT/C8FvBB/CyNT57yB5NUcGGujLvSHV6tH8EgBahj4oGEXcn5GqXgV3n3C5JRa2hGLT
         Embg==
X-Gm-Message-State: ACgBeo09kAVKaQZ6dlREStkQ0wgGV5XdxUOawC3Q6wqJmPHGlnyCTvfX
        Qs5PGJCkdXimZ6+vnNR3HoJodJj7JpgvQ77VC5oDNg==
X-Google-Smtp-Source: AA6agR4wyC1xKSB5T/Ub5O7BeqVM03r9pVrlYU9kuoQPBAtZM9DyISywpBVRa1T1DnGvqf1WNPLBGtyY/psjqRdwIDg=
X-Received: by 2002:a67:c198:0:b0:383:b020:f7c4 with SMTP id
 h24-20020a67c198000000b00383b020f7c4mr10129732vsj.71.1660711411110; Tue, 16
 Aug 2022 21:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAGi-RUKv-8zyku-3pjXdjxbyMP_X_YV5rd6y2wyaCOJJ9UOQAw@mail.gmail.com>
In-Reply-To: <CAGi-RUKv-8zyku-3pjXdjxbyMP_X_YV5rd6y2wyaCOJJ9UOQAw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 17 Aug 2022 12:43:19 +0800
Message-ID: <CABVgOSnxa=H5A-0U0QRCAv+OWCGb0zN_f7gP5FmhGjRy7NCUSw@mail.gmail.com>
Subject: Re: Running kunit tests on platform devices
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c08cb705e6688129"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c08cb705e6688129
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 15, 2022 at 5:16 PM Ramon Fried <rfried.dev@gmail.com> wrote:
>
> Hi.
> I implemented a test suite that checks a platform driver, that's the
> only way I can test interrupts behavior in the code.
> Because it's a platform, I can't use kunit_test_suite(), so I call
> __kunit_test_suites_init() as part of the platform driver probe
> function.
>
> This works fine but has the following problems.
> "TAP version 14" string is not printed and it's impossible to parse
> the results using the script.
> In addition, the suite is not displayed in /sys/kernel/debug/kunit.
>
> It would be my pleasure to provide a patch that fixes this, I just
> wanted to make sure that my testing strategy makes sense.
>
> Thanks,
> Ramon
>
Hi Ramon,

Thanks for reaching out. Calling __kunit_test_suites_init() directly
is not something we'd recommend (and are trying desperately to remove
existing uses), so several of the issues re: the "TAP version 14"
string et al are side effects of calling what is supposed to be an
internal KUnit function manually.

That being said, we definitely do want to make testing platform
drivers as convenient as possible. I'm not sure why kunit_test_suite()
doesn't work for you for platform drivers: are you just missing some
way of instantiating the device from within a test context?

I know Brendan has experimented with some hardware faking code, for
which there's some example use here:
https://kunit-review.googlesource.com/c/linux/+/5275
(Note that you'll need to look at the other patches in the 'relation
chain' for dependencies.)

Equally, I've experimented a bit with testing old soundcard drivers
(via a platform device) here, which may be an easier way to look
through:
https://github.com/sulix/linux/commit/4e1620c86553b9edde7f032318cf417dc13e4d26

Note that neither of those examples are anything other than
experiments, so may not work as-is, or be ideal.

Otherwise, we're always happy to accept patches, though again, if
there's any way of getting your tests working without a direct call to
__kunit_test_suites_init() --- even if that would require patches to
work --- that'd be preferable on our end.

Cheers,
-- David

--000000000000c08cb705e6688129
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCk
pkQ/NhpeDjUDEDxowN96OIHGPgIQ0eJo+gJ8tertRTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MTcwNDQzMzFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAf+63xKR8ufRwHmv8H0BU
KTRvfnhJNRE6QDCJhYphtd1RHnvgam+T8IWcb+SREAZTlz18Yjj6QPxaFcUI1PEIl0Vay678H/VL
ckTITmhTy8BSWZY7Oe2FtD+TzkvAI7WeyTYymIv1cf9vrVvVbTJiFWwNRfksctR/F6dSGrKcUGC0
bSVDc/AZj12jIAir0zFCTW/XnCbUlUnu4fF/RTO3/EQIS+BhNP8nqWw5V+t0kZKDpJ9rwUJwpHnd
N59IfW3hFtVrBAOaieg0XWKpo7AoGD6TcBBN3n5Lvci8cc2ROa5ZN7xBmHiyVvEmo+ni7ur5h6sm
fkPSfITDXKmFK6URsQ==
--000000000000c08cb705e6688129--
