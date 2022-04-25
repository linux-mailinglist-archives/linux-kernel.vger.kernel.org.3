Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204F450E6F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243872AbiDYRUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243983AbiDYRTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:19:47 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E4726AC4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:16:38 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t15so17859725oie.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dBhJQBFFy4Ceg8cAsnJhQlAVWnX2jFGl2toK7LYg2vI=;
        b=ZUI1SW0LDagU7wptgLkLAyo11l74Ya3MsuwD1LvUoGpHB7JFCD9eGwk+TPuFbsg94J
         1/2jlCIpJxuoSUuRE77FpuY8ivlJycTuspgiLAQKEm++YBdSPzIgc1bCHwvyU3bM1OIx
         QVQlUy6mpNLw/RH+old6c5hmH0AGxCuRDi6JZa0UvmfRHrSkPnUMz3ibircJSgTzvhqv
         vzyJoGr57dosEvqOjyqJIo0/ae+ilr8gmRG4Nybz3RfmwCFa0D2hnsmc/RJNg/8pRgkF
         kbG9O8mJJfwfTK2t76xzeoPxWz1lE+4Zb2NHMLo5de+3pUBSoQI789poPU5L2Sskqw9r
         QDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dBhJQBFFy4Ceg8cAsnJhQlAVWnX2jFGl2toK7LYg2vI=;
        b=WlosovNO2PqrGdq9NSkiGFFSY9Kt+ROu3yY6NagpfnQgBLaBR0vqTiOWSgOJEqZP7e
         LSWcQyLktFZK6wepXMCWB8XndgJKbPGemntdLX88FNLpdfZuQ0U/CBVS2ebavZUXNzTN
         1n6DKA3hihe0Aki9beKswKtujt3kTyu6MWs54rZyyHtOo1cCyNz3O7isSxeLXbnIXznE
         znT9NE13o8cArFFplBKB9piN9Tv/0cs4rygbgAgovw6A4KSydD2Xu+DhU8B+LhSC7oWJ
         mXl1jhOWrPw6LXQ1iEGVEJF/GklJliLz2meKLnVO8eQfcpTQBI9hsXZiuZHTKtBfc87L
         jWmQ==
X-Gm-Message-State: AOAM532f0LHekJJviEIdUrJOmGn8TA04jw7EZai0Ta/EUAWM8L6taVZL
        8np/sf5KQ1qWRDtpCO+vTfS9oQOWHMSMycbYoo2nfuYFwTe/zYwprSkmELW4pHcdoMC2IZ1gzqh
        YUFefm7/HSOOM2Eh/eASmI+UTWbS97ixq8vIErD2PhfigAIMrNpz504wk+AUU/Yar2r5+TZn6Zc
        NSb/QFO/QJtyFBNFOiisw=
X-Google-Smtp-Source: ABdhPJw2CA5OnWQr+1gbJ1Fj/HVda/dNTu+4D8Lx2yhRTTRMdTF6nMZAB44F7+DCfcQSISEqTGmGkw==
X-Received: by 2002:a54:4d86:0:b0:324:ecc3:fd02 with SMTP id y6-20020a544d86000000b00324ecc3fd02mr7359683oix.243.1650906997950;
        Mon, 25 Apr 2022 10:16:37 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id fz13-20020a056870ed8d00b000e593f1f26fsm3441269oab.18.2022.04.25.10.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:16:37 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v7 8/8] drivers/node: Show in sysfs node's crypto capabilities
Date:   Mon, 25 Apr 2022 14:15:26 -0300
Message-Id: <20220425171526.44925-9-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show in each node in sysfs if its memory is able to do be encrypted by
the CPU, ie. if all its memory is marked with EFI_MEMORY_CPU_CRYPTO in
the EFI memory map.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 Documentation/ABI/testing/sysfs-devices-node | 10 ++++++++++
 drivers/base/node.c                          | 10 ++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-node

diff --git a/Documentation/ABI/testing/sysfs-devices-node b/Documentation/ABI/testing/sysfs-devices-node
new file mode 100644
index 000000000000..5fd5dc7fc2eb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-node
@@ -0,0 +1,10 @@
+What:		/sys/devices/system/node/nodeX/crypto_capable
+Date:		April 2022
+Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
+Users:		fwupd (https://fwupd.org)
+Description:
+		This value is 1 if all system memory in this node is
+		marked with EFI_MEMORY_CPU_CRYPTO, indicating that the
+		system memory is capable of being protected with the
+		CPU’s memory cryptographic capabilities. It is 0
+		otherwise.
\ No newline at end of file
diff --git a/drivers/base/node.c b/drivers/base/node.c
index ec8bb24a5a22..1df15ea03c27 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -560,11 +560,21 @@ static ssize_t node_read_distance(struct device *dev,
 }
 static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
+static ssize_t crypto_capable_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct pglist_data *pgdat = NODE_DATA(dev->id);
+
+	return sysfs_emit(buf, "%d\n", pgdat->crypto_capable);
+}
+static DEVICE_ATTR_RO(crypto_capable);
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
+	&dev_attr_crypto_capable.attr,
 	NULL
 };
 
-- 
2.30.2

