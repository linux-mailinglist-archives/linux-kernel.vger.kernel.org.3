Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1910C488F33
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbiAJEWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiAJEW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:22:28 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EC7C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:22:27 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id p44so1582242pfw.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 20:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=WyfDXJ6AfYD5Wi27bgSv0f+lsggdE738NSw9SnqqQI4=;
        b=em2IrTCkKyjS2abrIYzGq5C/MoeOgjqhlom4nQOYxDNkQvlRVVsLHXK/r/iWfqm0P+
         HiaOecvKUBw7GyJIlBeAuPHC9YAh34dxhLQpMrHQXQe01q7gzp9tKDdtVo8hnwCPMZzw
         BzBe76er2dJtdRwVNtW5tA1KVtWEOPTgR6obY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=WyfDXJ6AfYD5Wi27bgSv0f+lsggdE738NSw9SnqqQI4=;
        b=oJgs4b5V0Xu+BrFunRI0LuLTLS+CQhe0D7xgjb5R0eSNAJRBJkGhz/RcKCYZWFngbW
         vBfvaV+M2qIKOCBMyAM8f9Q8XlqMyijQUcBdN+ii+3cXWSVTraj32bDolulu3znTda/j
         aDD1OJ9LSg5AGAmGVCgkeHprPQiGPKKw1f/S15x9iBi3BlIRTKxhxyPiKDxaytC4eqUz
         RqEml0MtukmbXEYGz4RSID5ANxfUoQaG4vNmzkqOrht6GotuzGl/unaD5TsWSpCiJ4hv
         4CYaqOpTqHBFknFZ4cd9JcSpMwz7CVteOe024ZsgyRz1E30cQ8ajWcjdZXeq1YRJbh+p
         zwkQ==
X-Gm-Message-State: AOAM533mSfH0sXNt4W1+6Jgju+pSDx3puhTzvEXqo6N1CE4jGAPFiDM2
        dHU7ZXuVlWeAbBmCfcL/yMcuLn+twT+Z7OfitqTBDA9Vt+bIJLwXmijuaiSZ8pNSkpeJ3Dszwq8
        cWGdOvkd1BjPi7OwoGGouDqpFOOavUsfJ6qHwgZcCoNfcx5MOsMb/7oiMdLDlVXupbYjypufFbv
        2qm65fZ4ny2Zpzp7M=
X-Google-Smtp-Source: ABdhPJzGEVloRdYs26MbOVZ5x5SAN0qvoIPfv61xyWiUTkJg/7V8lUEi3Hi02ptK0T2gUtAhnLgLCA==
X-Received: by 2002:a65:5a41:: with SMTP id z1mr64032849pgs.585.1641788546857;
        Sun, 09 Jan 2022 20:22:26 -0800 (PST)
Received: from ldt-sj3-komrakov.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id x2sm4024257pgo.2.2022.01.09.20.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 20:22:25 -0800 (PST)
From:   Alexander Komrakov <alexander.komrakov@broadcom.com>
To:     linux-kernel@vger.kernel.org
Cc:     giometti@enneenne.com,
        alexander komrakov <alexander.komrakov@broadcom.com>
Subject: [PATCH 1/1] Calculate the monotonic clock from the timespec clock to generate PPS elapsed real-time event value and stores the result into /sys/class/pps/pps0/assert_elapsed.
Date:   Sun,  9 Jan 2022 20:22:13 -0800
Message-Id: <20220110042214.1289369-1-alexander.komrakov@broadcom.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000029ceec05d532afb2"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000029ceec05d532afb2
Content-Type: text/plain; charset="US-ASCII"

From: alexander komrakov <alexander.komrakov@broadcom.com>

*** BLURB HERE ***

alexander komrakov (1):
  Signed-off-by: alexander komrakov <alexander.komrakov@broadcom.com>
    Replacing ktime_get_ts64 by ktime_get_boottime_ts64 because
    elapsedRealtime includes time spent in sleep and pps should be also
    including sleep time.

 drivers/pps/kapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1


-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--00000000000029ceec05d532afb2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVkwggRBoAMCAQICDHYIL0hy7FtCa0iawzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwNDMzNTVaFw0yMjA5MDEwNzU5MzNaMIGV
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDUFsZXggS29tcmFrb3YxLjAsBgkqhkiG9w0B
CQEWH2FsZXhhbmRlci5rb21yYWtvdkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQC9plVHzugCEzdkg+8eZF4DLPZ5fqspSSVbjMcgMDJQcAR76/SGGJnSJiHOj/rn
okK4r4HXW8cTMmw/ePqLs+eX7+h2TlrLFdwnPs6ThKSnKe7aNihCrk9rF+WyTTX/VrqyKPYICkp0
/XhRuIlIO0cP979rZRsxD4LKmC6x1msVkkM7JxkWhkktTzQwowAemtij6uzfYeh5BzQd2+LaWp8g
ZX2NhNnwh9gNMFxHdE5c6+G3LG7AHwFOPA6G1TuzZ35urQXh4HWGbGoCJPszKLgccfOBBHYaXyo6
yiBn77ZVlo89La3IlKW/J8Bg1ZiYHcR6RtGGylxCCKgFDdESfV03AgMBAAGjggHgMIIB3DAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCoGA1UdEQQjMCGBH2FsZXhhbmRlci5rb21yYWtvdkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFElfe2CJ
evQgM+vs7qmUiI/AGUBAMA0GCSqGSIb3DQEBCwUAA4IBAQCmTMsF9VHjT0L2ycGjBg8eb/+aTBhL
U6r4e4vaGj/xmDd1cWfvz4brxodjpmuSnjfyWvU/odcNIepLv17Xc91OiZBWGYgr4jNViUqunvaH
DCnJlLbrD88ITE1uo7OCdlN/SS+Sskp2dDvL/Xlyorb+PaS7/AaIwEmuGyJv2uv1wQ+UZzPXXo1B
vOM4N+PxiEKCkmmYhfeSVye92Bta6vjf0b+oDE2JT82+D+9nAfiyJ9P/SRVTTvLlSzcO2fqX6GOc
37xY9F5HGjunD+cc5mqKM/r5PXyM/LEzWjdU1lVUVuvLRerUn+GNFgAPzpksTVYDv2kuseIFwRrF
845kQxaRMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIM
dggvSHLsW0JrSJrDMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDlexjZT1R+BW87
VdNjy01grb05NUx0j1kfwuAiMAseeTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0yMjAxMTAwNDIyMjdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEArWO3Dr8VUsJmLgELwIjwlxA9DH5Rbas4
6JnKWGSJ70NgTZngi6MR8BOJEIV5PAnEJ4mGEJ78Yh/m+Koe/N0qlFyfd3+6ar4pONcHHxHssiID
Qglmk2TwnUHMt4yropcJBiEwWC/fQkHN2Tx5NhEdFDrgUAmbPTG4g0mJfyGlI/VLQhuvHWkeSjk3
g+Vmnj0I/bAfLwrJ7+N83L3cjcHySFDOZrEqKXntVVv2le2y15Kui81E5YLuDxtd84UA5DQdKHvf
pVbY+whUctEtSA2nDj9hkZ+/jl+P4Y5XE8607MmfrlYSRAlbMdJZgnCW8ctzZooQ2VH+LJ2XGaaT
+SAwYQ==
--00000000000029ceec05d532afb2--
