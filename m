Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069D847BFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhLUMb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhLUMb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:31:58 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739C6C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:31:58 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 8so11629900pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=99Dx373RUbXs1VdXWa06+vL9CDjG0+Rz+2/kNFo8gzQ=;
        b=YgunQ0OCtDpzHaE/S8OjxKN32xj/X0QfVt5S2ZwXiyNkrwAyQl0j6qz1vsloZAjfpP
         i56tAg6r+On5D5YAp0JaNA+jd4q80IuDZuwBq2FXeFpVkjP47LwVHmFiJMUhn+xkm/nF
         e/CKVrGm/gty79CzSsu3QFPJN314T4jvNB61w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=99Dx373RUbXs1VdXWa06+vL9CDjG0+Rz+2/kNFo8gzQ=;
        b=VbqBjlr07UEWHXChad7kQZR257RD/Se5T2DKKzhsJ61QJ/FSXi9DezpW93z45h2MQx
         cuRmiWj1wLP3LBoIqWPaBSIobyfZWU5OxNgbSIGxg9/p/TQ9lIUt0iBG0hNHlSDl7vdJ
         cp/6xP4FTvP1CM3m75Y71WO9E0WpZVWjqOnsN64bcJNptQYaSUiK+Da8BwqeSFlveEgX
         krFAmONNf0eQx/vRvWOby+P0qZxS7z9objLV3dI/f51LsW+KOr7N0tQkHN4UredDwJVc
         8409D+053gBihD+NbmJZAwu/rd8mxFw3mpuEwovqRtLL2oc2l9FkSIOyxpyc0qI3i0DV
         vw3w==
X-Gm-Message-State: AOAM530GhzK48sATFR6FrmIdpvdq5ZmU2fV1ABox+zyT2kL74gPmNXEP
        3hKkJImIOsgufXirBj/CyNQJrg==
X-Google-Smtp-Source: ABdhPJydVV3/fumPZDKV97gp7Ii5WuZWEopryLKWIlL9VVteH8v61RADRTTWKEqIkIMZ4aKLHjx02g==
X-Received: by 2002:a63:1a16:: with SMTP id a22mr2791752pga.208.1640089917793;
        Tue, 21 Dec 2021 04:31:57 -0800 (PST)
Received: from amd_smc.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t191sm19841156pgd.3.2021.12.21.04.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:31:56 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
To:     axboe@kernel.dk
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, ming.lei@redhat.com,
        sathya.prakash@broadcom.com
Subject: [PATCH RFT] blk-mq: optimize queue tag busy iter for shared_tags
Date:   Tue, 21 Dec 2021 18:01:57 +0530
Message-Id: <20211221123157.14052-1-kashyap.desai@broadcom.com>
X-Mailer: git-send-email 2.18.1
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f9c1b905d3a730ea"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f9c1b905d3a730ea

In [0], CPU usage for blk_mq_queue_tag_busy_iter() was optimized, but
there are still periodic call of blk_mq_queue_tag_busy_iter() from
below context. Below context is used for block layer timer to find out
potential expired command (per request queue) which requires tag iteration
almost every 5 seconds(defined BLK_MAX_TIMEOUT) for each request queue.

kthread
        worker_thread
        process_one_work
        blk_mq_timeout_work
        blk_mq_queue_tag_busy_iter
        bt_iter
        blk_mq_find_and_get_req
        _raw_spin_lock_irqsave
        native_queued_spin_lock_slowpath

Changes in this patch optimize extra iterations of tags in case of
shared_tags. One iteration of shared_tags can give expected results for
iterate function.

Setup -  AMD64 Gen-4.0 Server.
64 Virtual Drive created using 16 Nvme drives + mpi3mr driver (in
shared_tags mode)

Test command -
fio 64.fio --rw=randread --bs=4K --iodepth=32 --numjobs=2 --ioscheduler=mq-deadline --disk_util=0

Without this patch on 5.16.0-rc5, mpi3mr driver in shared_tags mode can
give 4.0M IOPs vs expected to get ~6.0M.
Snippet of perf top

  25.42%  [kernel]                               [k] native_queued_spin_lock_slowpath
   3.95%  [kernel]                               [k] cpupri_set
   2.05%  [kernel]                               [k] __blk_mq_get_driver_tag
   1.67%  [kernel]                               [k] __rcu_read_unlock
   1.63%  [kernel]                               [k] check_preemption_disabled

After applying this patch on 5.16.0-rc5, mpi3mr driver in shared_tags
mode reach up to 5.8M IOPs.

Snippet of perf top

   7.95%  [kernel]                               [k] native_queued_spin_lock_slowpath
   5.61%  [kernel]                               [k] cpupri_set
   2.98%  [kernel]                               [k] acpi_processor_ffh_cstate_enter
   2.49%  [kernel]                               [k] read_tsc
   2.15%  [kernel]                               [k] check_preemption_disabled


[0] https://lore.kernel.org/all/9b092ca49e9b5415772cd950a3c12584@mail.gmail.com/ 


Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: john.garry@huawei.com
Cc: ming.lei@redhat.com
Cc: sathya.prakash@broadcom.com
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
---
 block/blk-mq-tag.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 995336abee33..3e0a8e79f966 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -253,7 +253,8 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	if (!rq)
 		return true;
 
-	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
+	if (rq->q == hctx->queue && (rq->mq_hctx == hctx ||
+				blk_mq_is_shared_tags(hctx->flags)))
 		ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
 	blk_mq_put_rq_ref(rq);
 	return ret;
@@ -484,6 +485,14 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		if (tags->nr_reserved_tags)
 			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
 		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
+		
+		/* In case of shared bitmap if shared_tags is allocated, it is not required
+		 * to iterate all the hctx. Looping one hctx is good enough.
+		 */
+		if (blk_mq_is_shared_tags(hctx->flags)) {
+			blk_queue_exit(q);
+			return;
+		}
 	}
 	blk_queue_exit(q);
 }
-- 
2.18.1


--000000000000f9c1b905d3a730ea
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMI/9q2IGS2s59U9fxTHfXpNOgjw
GjhF3/t1AUceiuXFMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MTIyMTEyMzE1OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQDE0VTFyoYTj3tVyZ+nG2pNNo9Z+ctVIYuCe6zUb7x7uMjs
lpJp/dMHjWHw1UT22k230afodwOOvDRGP/kiwHC2BlnlUYVw3Y8zjggj5P8hocuGu7dy9ef2N0D2
zjK794DnicsR+zl1Scsw/UpLLN3V4NgebxghQgdhEpBnGuxF2Pr2lj82pef4p46FH2KZjjfYAaF7
W7EGAEbveOV9vkuFyoROdA7ZAeaAmbLC44JLnaaeBl93zRMVDdFtcpODNldqZffJ70Louqnuj0r7
0D1YqXcRtIBr57tGv6w1T9toCVkjhVlwLkp6l2+/HwLFWAhza2AovGI7r+SLjEaFb5W+
--000000000000f9c1b905d3a730ea--
