Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9674C9C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 04:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiCBDnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 22:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiCBDnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:43:04 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5A4B0EAF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 19:42:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so632326pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 19:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaKbUMAikoW+2CrT8M+EU3vclV/Hjqlxq8ONhSLeM1E=;
        b=2D4/T939Evpeki/nJ0chs+tQeIyQU/+z6U7Q3rDEcdOMLd5GtBzsn1fHAcLgpJbrb4
         Rx8Ci27MxIkvcUIeZUaLiXekDlZn36VK4l1GnjZWzTlaYRmwyYlO4roWuOpnWZ/TJoZd
         89f8ABoy080TOlgAchfJvRhoi4N1welgpRu801mxdptlmyfEl5c4O+7JG89L8JHb6ytc
         AOJeSBGCB1vOm+XBSh+Gz9GBYa2/7aKJnpDiNQR7T/q0pWqX3vAdsJi0ho9m2bFCOPrL
         t41JeeeAM+/xwt9a3da6oe0cVG0LmGrSUj+M/+4VKPROACsOb+ZJSXecV4F5QEZ1E5nf
         9qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaKbUMAikoW+2CrT8M+EU3vclV/Hjqlxq8ONhSLeM1E=;
        b=f6y0Na1k7MQgRAkqlbYRf6AgjbDvYKHmC4ypo8Rdq/h/QeKW9ICuVXEyJYJL2PwHPY
         3aeGxEBhULQyOjgBtu0zVwFKhdhiQ2JJkmYpzCND63Kes9L8ct9t5fluhyhAH6Jc23fq
         LAYt81AZVdeZZrkHjhNoWmcBEEAe7/M7Ek2KLDMy79RCiJLhcQIymNjGSAbOTIdNHnSY
         ABiQKGFO9UEMhkSAc0DWMcvfZ7Bv70ZVpUSX+2y5M0CKzjmr4o9Cw474woTUXgmAHQ2a
         x9IU0RE1nfLGi5X4kiKEoBnNSQFMqL/9mbSV13wKPppFPpzCEectx7cQjUFv3fwivPSj
         2j7w==
X-Gm-Message-State: AOAM530IGE5wlQUpFbZKVwUZVxTiIxL18UQXBKqByP8VHs7NzR712qng
        xDCxqeMA/DUADHoLcngQOfKup03Lmtv4AA==
X-Google-Smtp-Source: ABdhPJwgSX9MeLbuWXyzeWaVSztTZEp+pZTmnRRuCS08oSrYYEhSHkPNhNG8Jj3zmd9wQ+Lw+Z5/1g==
X-Received: by 2002:a17:902:8e82:b0:151:6f68:7088 with SMTP id bg2-20020a1709028e8200b001516f687088mr11139235plb.11.1646192540121;
        Tue, 01 Mar 2022 19:42:20 -0800 (PST)
Received: from always-x1.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id gz13-20020a17090b0ecd00b001bc5defa657sm3358585pjb.11.2022.03.01.19.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 19:42:19 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, helei.sig11@bytedance.com,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
Date:   Wed,  2 Mar 2022 11:39:13 +0800
Message-Id: <20220302033917.1295334-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
  Rename virtio_crypto_algs.c to virtio_crypto_skcipher_algs.c, and
    minor changes of function name.
  Minor changes in virtio_crypto_akcipher_algs.c: no need to copy from
    buffer if opcode is verify.

v1 -> v2:
  Fix 1 compiling warning reported by kernel test robot <lkp@intel.com>
  Put "__le32 akcipher_algo;" instead of "__le32 reserve;" field of
    struct virtio_crypto_config directly without size change.
  Add padding in struct virtio_crypto_ecdsa_session_para to keep
    64-bit alignment.
  Remove irrelevant change by code format alignment.

  Also CC crypto gurus Herbert and linux-crypto@vger.kernel.org.

  Test with QEMU(patched by the v2 version), works fine.

v1:
  Introduce akcipher service, implement RSA algorithm, and a minor fix.

zhenwei pi (4):
  virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
  virtio-crypto: introduce akcipher service
  virtio-crypto: implement RSA algorithm
  virtio-crypto: rename skcipher algs

 drivers/crypto/virtio/Makefile                |   3 +-
 .../virtio/virtio_crypto_akcipher_algs.c      | 585 ++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |   7 +-
 drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
 drivers/crypto/virtio/virtio_crypto_mgr.c     |  15 +-
 ...o_algs.c => virtio_crypto_skcipher_algs.c} |   4 +-
 include/uapi/linux/virtio_crypto.h            |  82 ++-
 7 files changed, 693 insertions(+), 9 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
 rename drivers/crypto/virtio/{virtio_crypto_algs.c => virtio_crypto_skcipher_algs.c} (99%)

-- 
2.20.1

