Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8636A515567
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380678AbiD2UWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380676AbiD2UV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:21:57 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB46D5E99
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:18:38 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso5840413otk.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkG/F7+kBMNIWCowVtEazmyHhBwO2DxtbJbfhKP712A=;
        b=CFVomb+9tyTJtBjEhdpiH1zhwooGhEZao10gTFdxqakjE50a70JiLTBnTH7LkExN+V
         oc+UNf8vfz0q7LVdjvbwtCy8BnniQSsjA83H+fwEwh99U6UXRuClAcfUpV3bpAAc9umN
         hs0O4wqgUFbbSCgB/tJAtF1o+ndijINfhWVCNdR3bBValgZ8Z1AMvT3jzPCO56a+EUVj
         eQw67Azpa5Iv4+Ywhr9kjCjFBO3QXN4+XwHcJopDuXewZTbZD9+wbmGww65HIywNbytB
         K9o9k/DmPxRb4TRXsls4NQStEslTiFL+j1mwuEZbxJ6bjwWQEk+zv+NX6GgbMX2SInsf
         YuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkG/F7+kBMNIWCowVtEazmyHhBwO2DxtbJbfhKP712A=;
        b=2Oy/nlKVjX53D+Ci1JbOlzRDRJm6HZJhBha9Cy3QlMxrSm87zde/vibYlkpzlKDtpP
         2iGKgD7ycj5DbksuxvV/egwqryWjKmLRR0M+ebUq/+LxU3OoPtXJOSejCc2w9n7I/DsU
         NHTjBVToX4tMfznwtFWqhgwArhdu4zRdpUMLFk5xhrI30WN/zxGNwYG0XTZJVXCiezUe
         CFCk5iw2hVyOkPturXguB4Em4vnhn+guHaWm+qKMKjArNglomdD7JRth26ZJAhkQQVae
         uU3VHvh6kFWKLGn11ZW49b5V1cGEoTapa3kELSLfjDmt/LN/ORFlh8+9sOuO+82Embe/
         IiUg==
X-Gm-Message-State: AOAM530EkgduK0D87sW7IiTLRU4Q5dDDVBAjb57wwcwZnAk010eurPW7
        AO4CtwwXgbXU/QE5H0SPTv7ESBqk4+cRBlsWzy9zLzpGerv5GShGFGoSjdyWHzndYjdyD9FAFBf
        2sGujZN3lfPJta4vRQUrYRKSTMjutn+/kPNI9iafkbuwlieKPRWLx+UFqdH2U1a4H/9njY3naHo
        v+90VIfqmAuRz/AIEIyg4=
X-Google-Smtp-Source: ABdhPJwfcMjRvkAXKIDIz9yJyzv/MGd9Qc+uZBZYcbTg+2X+d01VGqB1uGOCZg191g8uEunpkZerYw==
X-Received: by 2002:a9d:37cb:0:b0:5cc:7a51:c984 with SMTP id x69-20020a9d37cb000000b005cc7a51c984mr409643otb.98.1651263517007;
        Fri, 29 Apr 2022 13:18:37 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id t13-20020a05683014cd00b0060603221245sm79060otq.21.2022.04.29.13.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:18:36 -0700 (PDT)
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
Subject: [PATCH v8 8/8] drivers/node: Show in sysfs node's crypto capabilities
Date:   Fri, 29 Apr 2022 17:17:17 -0300
Message-Id: <20220429201717.1946178-9-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
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
the CPU; on EFI systems: if all its memory is marked with
EFI_MEMORY_CPU_CRYPTO in the EFI memory map.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 Documentation/ABI/testing/sysfs-devices-node | 10 ++++++++++
 drivers/base/node.c                          | 10 ++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-node

diff --git a/Documentation/ABI/testing/sysfs-devices-node b/Documentation/ABI/testing/sysfs-devices-node
new file mode 100644
index 000000000000..0e95420bd7c5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-node
@@ -0,0 +1,10 @@
+What:		/sys/devices/system/node/nodeX/crypto_capable
+Date:		April 2022
+Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
+Users:		fwupd (https://fwupd.org)
+Description:
+		This value is 1 if all system memory in this node is
+		capable of being protected with the CPU's memory
+		cryptographic capabilities.  It is 0 otherwise.
+		On EFI systems the node will be marked with
+		EFI_MEMORY_CPU_CRYPTO.
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

