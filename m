Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950E3488F34
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbiAJEWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiAJEWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:22:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C168C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:22:42 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p14so10851888plf.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 20:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=2tMVLcwqOwvdNbUwarTtkg+jpTBxZUsNlQmGjyUWQAI=;
        b=ZVvL0Tl/4WjO5EibOz/XcczYAW/yC6ZMJs+NmD1bHvjoFkaZFO2+3muMMTrtV5kSyF
         NCty9641O594k+RODiiyi+wDyTcnChyk9qEvABt/P2P6+KXqMAz1mRG7UOozvtrtCN5D
         6JpE8dq8c/BjuOx3mBw6oLVC+hQsK5ncexd2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=2tMVLcwqOwvdNbUwarTtkg+jpTBxZUsNlQmGjyUWQAI=;
        b=GLZj9TZNrHDUu3wci4E3w10fJ3Nh97UrrCfGNv8BalNSvlD3+9xOwo/HVxjXiLy06J
         bkPaBShv10xOy/a+KMK7nsjq/oS9Wo1wF5XOoMJzwTePnQtmpg43U366OEO0mv0zTRGd
         7kKuK7oewXyFyUjTRY93RYSBrlPRAUGF68LB6QDhiA64yBX/orRjeHD5M9j8+ywyfuPO
         Vl5DKVLXKTw6aGSJzfA3CBf60EpVxvO0Q76zJPTjqh7IT6JIDdTdn2oBLPcarkWfzCuB
         93kKjjfSa2XPecCUHyMIUf/euEpYiavwEsM6mf0FUklrIYNzluAYD3O6sB1hRVOnAx1x
         Z6vQ==
X-Gm-Message-State: AOAM531aI960GHte1nja4TzY70fvtTK9FNT3mwZj7RILzOQ7Nzz2U9xn
        B22toxBlCUBD2pJX8mUUaloydEwOxazMhIiZ5AeejMsK0MKFIBZOyobJcoAcDw48JiaO9DUUzHh
        CIu94gmARrm/mgyzuodo75fgTNub98uOoVq9LEtRjsQKQyqpHIO+Laez67ZHBjde5tGY7m9+ujB
        MUqv0gsQOSh5cCi7M=
X-Google-Smtp-Source: ABdhPJxeqzT9Iy/JuXzwRDo+Xq+a8eoV8hGOrkyzdYDO3f1mjkqpfThIPtY1lKS9pZxQf1YPFeYFCg==
X-Received: by 2002:a17:90a:cb8b:: with SMTP id a11mr3538448pju.75.1641788561126;
        Sun, 09 Jan 2022 20:22:41 -0800 (PST)
Received: from ldt-sj3-komrakov.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id x2sm4024257pgo.2.2022.01.09.20.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 20:22:40 -0800 (PST)
From:   Alexander Komrakov <alexander.komrakov@broadcom.com>
To:     linux-kernel@vger.kernel.org
Cc:     giometti@enneenne.com,
        alexander komrakov <alexander.komrakov@broadcom.com>
Subject: [PATCH 1/1] Signed-off-by: alexander komrakov <alexander.komrakov@broadcom.com> Replacing ktime_get_ts64 by ktime_get_boottime_ts64 because elapsedRealtime includes time spent in sleep and pps should be also including sleep time.
Date:   Sun,  9 Jan 2022 20:22:14 -0800
Message-Id: <20220110042214.1289369-2-alexander.komrakov@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110042214.1289369-1-alexander.komrakov@broadcom.com>
References: <20220110042214.1289369-1-alexander.komrakov@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000033ae505d532b07d"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000033ae505d532b07d
Content-Type: text/plain; charset="US-ASCII"

From: alexander komrakov <alexander.komrakov@broadcom.com>

---
 drivers/pps/kapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index 149c29e498fc..6d1fbe4a8c40 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -38,7 +38,7 @@ static __u64 clock_gettime(struct pps_ktime *kt)
 {
 	struct timespec64 ts = { .tv_sec = 0, .tv_nsec = 0 };
 
-	ktime_get_ts64(&ts);
+	ktime_get_boottime_ts64(&ts);
 	kt->sec = ts.tv_sec;
 	kt->nsec = ts.tv_nsec;
 	return (__u64) ts.tv_sec * NANOSEC_PER_SEC + ts.tv_nsec;
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

--000000000000033ae505d532b07d
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
dggvSHLsW0JrSJrDMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDnp0iM/gv1H82L
u8mn8w+sdfmx01gtgsamWfo2N+mrOjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0yMjAxMTAwNDIyNDFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAM0Lj+wFm/pAZH8cg7/Ce+kc35fBYVLrB
LCItcrRO8QVtO53VJsdnDyF+/j/NzZlv75vqQOhS0furKeTTT+GBhehO6TI6U59nd6k7WwZLpD/C
KIkEYAksrIAudS/bd7h+0cAkhM7XL7mWl1JKrPVBje/UasqT9HnfFm4KATe48AgMDrMd3MVEfP3R
VxQRtiE8wpkfSWmp9eZ80U4XUadNUGSQWGrui95TI75H6Xmnulr3jA665NDODF87THi4IMLwWrdw
quxrQRKiQ91AHwhG7KTkuIlMSckTA9jF/jO4WNrHDzeAjjNo+sRYFj62Y+MMsG86BzgONkl8F1gA
8/o9Gw==
--000000000000033ae505d532b07d--
