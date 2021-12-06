Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98D546932B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbhLFKGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbhLFKGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:06:38 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5E5C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 02:03:10 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id q14so10230216qtx.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 02:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=nHkoMfhl61KJxvXvzcHThf/NYH7V5w727wW3KY5V1gI=;
        b=J8xmJYXuDa3GYrSARfUzuZM3cljKtqtQtyWNElH8JnwV0HB3KtvmylNvC7CP3ILljX
         DOfo+iHXdIYPLp3DkamhCrCxNsSCI1swwDtVkXHHkoVKAOl3Qe1d/jpMmME4/AiG2azG
         yJspmDCjfqv8xWT0L875W7JVNBoKXcvuLYeKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=nHkoMfhl61KJxvXvzcHThf/NYH7V5w727wW3KY5V1gI=;
        b=a37B9jYEbzHnUMfjrvUftjtM/Dy0//f1ih2buvOzHxaaVcI+nBnep8692yn4BdZJ2Z
         XIbV6gqp4r580+ZgyfY0x/AEmb5uN3ALePmm6utXLiUiyEQGTi6tiZaJLaZiLY0AwR8u
         HGFDCZVEDqR8wDaJGsE/A8GwXaGAMCqU13yBeOvZNnFslhDGi5tYmPNjJcmaTJ+p97nV
         w3mmOPzYNsPtbq/lkBAaua8J0iaW0A92cxh0njBgwu9Xdlx7LNL+Hl3qR1npD6sEwvri
         XLBpxZAsr5qkEAAodJ5qkopGrytZ3jBYGA4np4w6S6LkL3DO/OIIHKMPLwsP2h5vFv/i
         +Z1Q==
X-Gm-Message-State: AOAM532qnxvjrRu8VoyrjwMeLtN75xarW8H379i/n+sS5x15qU+rglA0
        3oTfgh2uRssKmtT6O2zfq5gXN+5vMRPyvq6YU9+LEQ==
X-Google-Smtp-Source: ABdhPJw/D3qqhqe/KDjP2Am+KraKn7euS8cMzbgr4VcLIMhC0UM92oQA2c6lDNdKezrf/ZOThMRMQD/gorKs9rjM6mI=
X-Received: by 2002:a05:622a:1902:: with SMTP id w2mr2291322qtc.401.1638784989454;
 Mon, 06 Dec 2021 02:03:09 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
 <7fba1b1e-63a6-6315-e5ca-6d5ae9de6dbb@huawei.com> <b18285f4aa0e8be796aea19cdfde0293@mail.gmail.com>
 <9859e133-e3b8-4e53-dfad-cbf75ed3102f@huawei.com> <9b092ca49e9b5415772cd950a3c12584@mail.gmail.com>
 <fbdf64cd-7d31-f470-b93c-5b42a1e1cf40@huawei.com> <e6069080-61e7-4345-8ff3-a26756a1c76c@huawei.com>
In-Reply-To: <e6069080-61e7-4345-8ff3-a26756a1c76c@huawei.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJUjX6rU/P5SPFd3QoAV879Bj3AJQMPa4fEAveY/XABRUvQFwJpsFztAaeu4aoBElJW86rIdViA
Date:   Mon, 6 Dec 2021 15:33:07 +0530
Message-ID: <205b1962196d64a93184dc4023499e2e@mail.gmail.com>
Subject: RE: [PATCH RFT 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for
 shared tags
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, hare@suse.de
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002ccf8c05d2775daa"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002ccf8c05d2775daa
Content-Type: text/plain; charset="UTF-8"

> -----Original Message-----
> From: John Garry [mailto:john.garry@huawei.com]
> Sent: Monday, December 6, 2021 3:28 PM
> To: Kashyap Desai <kashyap.desai@broadcom.com>; axboe@kernel.dk
> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
> ming.lei@redhat.com; hare@suse.de
> Subject: Re: [PATCH RFT 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter()
> for shared tags
>
> On 26/11/2021 11:51, John Garry wrote:
> >> This patch set improves above call trace even after disk_util=0 is set.
> > ok, fine. Thanks for testing.
> >
> > So I guess that this is a regression, and you would want this series
> > for v5.16, right? My changes were made with v5.17 in mind.
> >
> > I am not sure how Jens feels about it, since the changes are
> > significant. It would be a lot easier to argue for v5.16 if we got to
> > this point earlier in the cycle...
> >
>
> note: I will now resend for 5.17 and add your tested-by, please let me
> know if
> unhappy about that.

John - 5.17 should be OK. I am doing additional testing and so far no issue.

Tested-by: Kashyap Desai <kashyap.desai@broadcom.com>

>
> > Anyway, it would be good to have full review first, so please help
> > with that.
> >
> > @Ming, can you please give feedback on 3/3 here?
>
> Thanks and also to Hannes for the reviews.
>
> john

--0000000000002ccf8c05d2775daa
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQcAYJKoZIhvcNAQcCoIIQYTCCEF0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3HMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU8wggQ3oAMCAQICDHA7TgNc55htm2viYDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIxMjU2MDJaFw0yMjA5MTUxMTQ1MTZaMIGQ
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDUthc2h5YXAgRGVzYWkxKTAnBgkqhkiG9w0B
CQEWGmthc2h5YXAuZGVzYWlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAzPAzyHBqFL/1u7ttl86wZrWK3vYcqFH+GBe0laKvAGOuEkaHijHa8iH+9GA8FUv1cdWF
WY3c3BGA+omJGYc4eHLEyKowuLRWvjV3MEjGBG7NIVoIaTkH4R+6Xs1P4/9EmUA0WI881B3pTv5W
nHG54/aqGUDSRDyWVhK7TLqJQkkiYKB0kH0GkB/UfmU/pmCaV68w5J6l4vz/TG23hWJmTg1lW5mu
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICnhX+wbtzsJSC4aASLw0GJnwzC1
tXWx80CpBWMIFCoMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MTIwNjEwMDMwOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAa4XAm8hc2ydC8nxlGy8CM9mUudloZjiU7+22Sd9dtPHuF
NlJY7bzb5o0F/pn8dlRG3sLKiPKSSV1cxU5fiB0x5xuzJENGJE7Wj57vy3YjlCcc3oglLibkJe2H
Ep2CbGw9Ppe+3SODqvBDAVx8WV/9YLlhmrdBsJtWf93eYJJKQ01C8gLGn0EsmJcewcKbtMEPXj/f
1SBktb8htEqBkLvG1gCg6/ghMdjAe4HZllalLlCgfAUFrfHyQr177dY+hWjFAlfGZjGuvjWsEipg
7G3Uv8h2Om4eJEm21kj9SRaLrZTGH/YPNHr5cUY8qxGvicxDkhLhsm4TpLgkXHBoJUND
--0000000000002ccf8c05d2775daa--
