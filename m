Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456B348CE39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 23:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiALWHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 17:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiALWG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 17:06:58 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96914C061751
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 14:06:57 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so7715837pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 14:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q/Rw7FotPPkrKYndyOgdWEBeHtrt7+KjvpPJ57SkSzc=;
        b=M2mZSobf4d4eeVcxQP1Jrxt7Id2BeGFwVA3ITVbXbOhUJdYhdxHFX40oE6DioWGl4O
         g/l8qcZbSvAtB8cMQpkVOdgLnnUbLiqaj3FU21EKb1oXAbzpD2UFk7Fmktd8w4/GULgX
         XbH0nixftmqlzHW6zqOjsUdS7n0u0Zuhdedns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q/Rw7FotPPkrKYndyOgdWEBeHtrt7+KjvpPJ57SkSzc=;
        b=1z3HDIuj6BPrUZutqCH6fnrGsGX+Ytxcgso/afXju1PsT7qgK11wXSfqNc/e5RoHdp
         OE9ovJXIkn9BV3DXR2Gh6bg39UnPE7vVP1hHzfUd7PMJnT9LhfM0rC3YCDPEx0O28nIi
         ujx8wBTikZp48C04KTKC4i61jI4hXS4JxyxspoB+dx6DzrrYwSRn+e+wD+F8yFenW4t0
         WqyoHVUbVms3FIHMKX+9Zi2rVKEIxqt44ytfht4XkFdFqP/gJWoo6QagR/q9SYGH847o
         pDFBm+CWMNDzHoHDGONcDGCn+4/oxDKzLCoLINnEtUnrjOK5UaIFZPCOkm4wlYA//Thu
         cMmg==
X-Gm-Message-State: AOAM533pkDUlM/lNAcK5WxSyZAXvmkFlpI6IKcm5tAQ39fbRNbqlzuuL
        7K0PXgyITPTLUH0hpqtxtWOHKA==
X-Google-Smtp-Source: ABdhPJxHS1d3NtDu9tsgszKg+aLDICclfZW7VSrDCu8GTyU3Rp0cYM7PBRDsjzh2cNHCIDRJt3t5ZA==
X-Received: by 2002:a17:90b:4b4d:: with SMTP id mi13mr11421553pjb.48.1642025216967;
        Wed, 12 Jan 2022 14:06:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z3sm570609pjq.32.2022.01.12.14.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 14:06:56 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>, linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH][RESEND] sata_fsl: Use struct_group() for memcpy() region
Date:   Wed, 12 Jan 2022 14:06:52 -0800
Message-Id: <20220112220652.3952944-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2183; h=from:subject; bh=5p121XAzQa6qN5E6EhVnf7REcLupYKUuIK7FpZN6ZM4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh31D8twxgwYJUCIhYXTXOl2rV+4GHrPs7/ZvQKKBy +ARWDKqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYd9Q/AAKCRCJcvTf3G3AJjzpD/ 0Xo3PYXRnkZQETy6n35GeZuDyC+Ugk2TK/R73XlSmpkKy04rQ8vVL0Xo5tqtyJMN2cHsmx1TWPdLW5 geORAPhsd/9iTzUnJ3AyTHloTYg1EqRG+N/HZt96lfbgo4M9dKO8PitIoiuYB2IlkdWWNXyROeeZvh EEx4vNPTFuG4jWVBCo+3tTf84940m8tTtYJy4iOoBt7Yhl7G9kbovJ7DRuyLzW9jmdFlT7Yx5AnNfr We3OO0gK6HZz/XAs5BKJZo/VvscsvDv4ugVKLILZ82OU/ymjXxWxct5dAZpl2NjdNDfrUvVZo1YETk gJys9zx6eBBpmYuVUCoJJ9WvmOocpIEgygzQrhtMMi5GK15BNF7F04Gi6nK4gjXPaIL5p6FiE0QcTG kqCapgEIJ3NXyKRlkW1tCcs6Fw81MZN6uz7XbL8vQP1H6dlsXQ+u6qRPNpSmi4pqetB49WO8OcI5Np 1d+XGX9T2huW6tKidhAlchxvksyLvWZ8TBZ53eUco115XjZHXbH4th4StPdtCZLPdnrTpSFZYAe9EM w4brwIav9TWKYyiCDIVoFmC5JkG4BDzFWdlc0G/Lr9amltMMlx3jJjA+XeLNuwBW0ctcX9cUNzMJZm l0CWyNvLLkkW6fsyXbdI0xX4TgunorbferXwwKCawdNmUHcoz/yN2wOdjinw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct command_desc around members acmd and fill,
so they can be referenced together. This will allow memset(), memcpy(),
and sizeof() to more easily reason about sizes, improve readability,
and avoid future warnings about writing beyond the end of acmd:

In function 'fortify_memset_chk',
    inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  199 |    __write_overflow_field();
      |    ^~~~~~~~~~~~~~~~~~~~~~~~

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Jens, can you take (or Ack) this? It's a dependency for the FORTIFY_SOURCE
improvements that are close to being finished. :)
---
 drivers/ata/sata_fsl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 3b31a4f596d8..c5a2c1e9ed6b 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -246,8 +246,10 @@ enum {
 struct command_desc {
 	u8 cfis[8 * 4];
 	u8 sfis[8 * 4];
-	u8 acmd[4 * 4];
-	u8 fill[4 * 4];
+	struct_group(cdb,
+		u8 acmd[4 * 4];
+		u8 fill[4 * 4];
+	);
 	u32 prdt[SATA_FSL_MAX_PRD_DIRECT * 4];
 	u32 prdt_indirect[(SATA_FSL_MAX_PRD - SATA_FSL_MAX_PRD_DIRECT) * 4];
 };
@@ -531,8 +533,8 @@ static enum ata_completion_errors sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 	/* setup "ACMD - atapi command" in cmd. desc. if this is ATAPI cmd */
 	if (ata_is_atapi(qc->tf.protocol)) {
 		desc_info |= ATAPI_CMD;
-		memset((void *)&cd->acmd, 0, 32);
-		memcpy((void *)&cd->acmd, qc->cdb, qc->dev->cdb_len);
+		memset(&cd->cdb, 0, sizeof(cd->cdb));
+		memcpy(&cd->cdb, qc->cdb, qc->dev->cdb_len);
 	}
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
-- 
2.30.2

