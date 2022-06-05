Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D63153DCD2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351160AbiFEQIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241758AbiFEQIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:08:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E14D64FD;
        Sun,  5 Jun 2022 09:08:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kq6so11702498ejb.11;
        Sun, 05 Jun 2022 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ixPNpJXNxCrkH6m95bjklRlhnWHapvw1lTyCnMl6Iq0=;
        b=YuECi+VeLtzEzHynphVhiRdt2h+Qv9lB4MNEgjeCnoWBmZKhoxaS+aj0WFoFqlTU2L
         mPGXhTFSARG9ocIKefhlHDIn+NAMjMQUzgkYYjwGepsirFG0b9BCaqiH4CwGFIQb95Q/
         wiUbxAQj/8WFG+RAT4dN1lENTq11F2EAs0MNbgxJI4qu14Z4KenniYy9fQnq4YoYGArj
         U/xtUfAEBxZbwGoHbhxZgf0+IWsHPSrJVogzMGsxsNGDOliPeDKprDnuzBr7wi8C723k
         vRBo47cX+SRb4Lf1RurN2uXfdvT+xjoBhtRTOJa8snOu/yqk0Ho62bkT6m+5oLAn65t2
         R40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ixPNpJXNxCrkH6m95bjklRlhnWHapvw1lTyCnMl6Iq0=;
        b=zSAwQs0L+gdTH/8mCv6RpP/v8xl1/oo/Q8+M7Om/zk5hJjxX2AqGVZaJKHKby3o9n6
         ZynTPfgtqvm6SPy9Cmc2bb9BVY4sf66s4USDO0V47yuJmKXWcbA64lNS6emJYW8d440o
         xft6YeTMfeRWu164aqcU7aAjjvv25gLFnpYOTjCfuDck1wdfg3zooF70VQ1UNa0tn11I
         TXodAPRGwkh8Ovid9S2pK2fEn7V7ZlMjHN8O5//1G674TxSs40qnmcWugc0+7DU+iH5X
         wg0YjPR73kL9bgLAhkZywRTVhC0DX8BoVaNUIU9+A7eHHDXZM3q3xycecOUYyO2ifogT
         cVSQ==
X-Gm-Message-State: AOAM53095iw7uMZEmIwTjxBv+LbzIM8/0nkV0PP/TDpXaplWJgUqa6GW
        LvWrpDjjC0r22d4ohtnmsXU=
X-Google-Smtp-Source: ABdhPJy2BImOXcanYZF8iu5ps21IUE5ngzF2qvl41n7fSdnapoWccPwSFSffG4PFxKwSG6NpG/zvjw==
X-Received: by 2002:a17:907:1c2a:b0:6ff:4275:1e54 with SMTP id nc42-20020a1709071c2a00b006ff42751e54mr18111035ejc.138.1654445295762;
        Sun, 05 Jun 2022 09:08:15 -0700 (PDT)
Received: from localhost.localdomain (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id j3-20020a170906050300b006fed99e1143sm5242240eja.61.2022.06.05.09.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 09:07:58 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH] ia64: fix sparse warnings with cmpxchg() & xchg()
Date:   Sun,  5 Jun 2022 18:07:38 +0200
Message-Id: <20220605160738.79736-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <87h7547k8c.fsf@toke.dk>
References: <87h7547k8c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On IA64, new sparse's warnings where issued after fixing
some __rcu annotations in kernel/bpf/.

These new warnings are false positives and appear on IA64 because
on this architecture, the macros for cmpxchg() and xchg() make
casts that ignore sparse annotations.

This patch contains the minimal patch to fix this issue:
adding a missing cast and some missing '__force'.

Link: https://lore.kernel.org/r/20220601120013.bq5a3ynbkc3hngm5@mail
Reported-by: kernel test robot <lkp@intel.com>
Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

Note: This patch is only compile tested on defconfig. The corresponding
      binary is unchanged (except some .rodata with the kernel version)
      as it should be.

 arch/ia64/include/uapi/asm/cmpxchg.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/ia64/include/uapi/asm/cmpxchg.h b/arch/ia64/include/uapi/asm/cmpxchg.h
index 2c2f3cfeaa77..ca2e02685343 100644
--- a/arch/ia64/include/uapi/asm/cmpxchg.h
+++ b/arch/ia64/include/uapi/asm/cmpxchg.h
@@ -33,24 +33,24 @@ extern void ia64_xchg_called_with_bad_pointer(void);
 									\
 	switch (size) {							\
 	case 1:								\
-		__xchg_result = ia64_xchg1((__u8 *)ptr, x);		\
+		__xchg_result = ia64_xchg1((__u8 __force *)ptr, x);	\
 		break;							\
 									\
 	case 2:								\
-		__xchg_result = ia64_xchg2((__u16 *)ptr, x);		\
+		__xchg_result = ia64_xchg2((__u16 __force *)ptr, x);	\
 		break;							\
 									\
 	case 4:								\
-		__xchg_result = ia64_xchg4((__u32 *)ptr, x);		\
+		__xchg_result = ia64_xchg4((__u32 __force *)ptr, x);	\
 		break;							\
 									\
 	case 8:								\
-		__xchg_result = ia64_xchg8((__u64 *)ptr, x);		\
+		__xchg_result = ia64_xchg8((__u64 __force *)ptr, x);	\
 		break;							\
 	default:							\
 		ia64_xchg_called_with_bad_pointer();			\
 	}								\
-	__xchg_result;							\
+	(__typeof__ (*(ptr)) __force) __xchg_result;			\
 })
 
 #ifndef __KERNEL__
@@ -76,42 +76,42 @@ extern long ia64_cmpxchg_called_with_bad_pointer(void);
 									\
 	switch (size) {							\
 	case 1:								\
-		_o_ = (__u8) (long) (old);				\
+		_o_ = (__u8) (long __force) (old);			\
 		break;							\
 	case 2:								\
-		_o_ = (__u16) (long) (old);				\
+		_o_ = (__u16) (long __force) (old);			\
 		break;							\
 	case 4:								\
-		_o_ = (__u32) (long) (old);				\
+		_o_ = (__u32) (long __force) (old);			\
 		break;							\
 	case 8:								\
-		_o_ = (__u64) (long) (old);				\
+		_o_ = (__u64) (long __force) (old);			\
 		break;							\
 	default:							\
 		break;							\
 	}								\
 	switch (size) {							\
 	case 1:								\
-		_r_ = ia64_cmpxchg1_##sem((__u8 *) ptr, new, _o_);	\
+		_r_ = ia64_cmpxchg1_##sem((__u8 __force *) ptr, new, _o_);	\
 		break;							\
 									\
 	case 2:								\
-		_r_ = ia64_cmpxchg2_##sem((__u16 *) ptr, new, _o_);	\
+		_r_ = ia64_cmpxchg2_##sem((__u16 __force *) ptr, new, _o_);	\
 		break;							\
 									\
 	case 4:								\
-		_r_ = ia64_cmpxchg4_##sem((__u32 *) ptr, new, _o_);	\
+		_r_ = ia64_cmpxchg4_##sem((__u32 __force *) ptr, new, _o_);	\
 		break;							\
 									\
 	case 8:								\
-		_r_ = ia64_cmpxchg8_##sem((__u64 *) ptr, new, _o_);	\
+		_r_ = ia64_cmpxchg8_##sem((__u64 __force *) ptr, new, _o_);	\
 		break;							\
 									\
 	default:							\
 		_r_ = ia64_cmpxchg_called_with_bad_pointer();		\
 		break;							\
 	}								\
-	(__typeof__(old)) _r_;						\
+	(__typeof__(old) __force) _r_;					\
 })
 
 #define cmpxchg_acq(ptr, o, n)	\
-- 
2.36.1

