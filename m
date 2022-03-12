Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0204D6E28
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 11:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiCLKcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 05:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiCLKb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:31:59 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD0E23D03B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:30:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFzbY49qKz4xMW;
        Sat, 12 Mar 2022 21:30:49 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <eff9b2b211957fa2e8707e46f31674097fd563a3.1644588972.git.christophe.leroy@csgroup.eu>
References: <eff9b2b211957fa2e8707e46f31674097fd563a3.1644588972.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/64: Force inlining of prevent_user_access() and set_kuap()
Message-Id: <164708098863.827774.14061514441187973673.b4-ty@ellerman.id.au>
Date:   Sat, 12 Mar 2022 21:29:48 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 15:16:51 +0100, Christophe Leroy wrote:
> A ppc64_defconfig build exhibits about 10 copied of
> prevent_user_access(). It also have one copy of set_kuap().
> 
> 	c000000000017340 <.prevent_user_access.constprop.0>:
> 	c00000000001a038:	4b ff d3 09 	bl      c000000000017340 <.prevent_user_access.constprop.0>
> 	c00000000001aabc:	4b ff c8 85 	bl      c000000000017340 <.prevent_user_access.constprop.0>
> 	c00000000001ab38:	4b ff c8 09 	bl      c000000000017340 <.prevent_user_access.constprop.0>
> 	c00000000001ade0:	4b ff c5 61 	bl      c000000000017340 <.prevent_user_access.constprop.0>
> 	c000000000039b90 <.prevent_user_access.constprop.0>:
> 	c00000000003ac08:	4b ff ef 89 	bl      c000000000039b90 <.prevent_user_access.constprop.0>
> 	c00000000003b9d0:	4b ff e1 c1 	bl      c000000000039b90 <.prevent_user_access.constprop.0>
> 	c00000000003ba54:	4b ff e1 3d 	bl      c000000000039b90 <.prevent_user_access.constprop.0>
> 	c00000000003bbfc:	4b ff df 95 	bl      c000000000039b90 <.prevent_user_access.constprop.0>
> 	c00000000015dde0 <.prevent_user_access.constprop.0>:
> 	c0000000001612c0:	4b ff cb 21 	bl      c00000000015dde0 <.prevent_user_access.constprop.0>
> 	c000000000161b54:	4b ff c2 8d 	bl      c00000000015dde0 <.prevent_user_access.constprop.0>
> 	c000000000188cf0 <.prevent_user_access.constprop.0>:
> 	c00000000018d658:	4b ff b6 99 	bl      c000000000188cf0 <.prevent_user_access.constprop.0>
> 	c00000000030fe20 <.prevent_user_access.constprop.0>:
> 	c0000000003123d4:	4b ff da 4d 	bl      c00000000030fe20 <.prevent_user_access.constprop.0>
> 	c000000000313970:	4b ff c4 b1 	bl      c00000000030fe20 <.prevent_user_access.constprop.0>
> 	c0000000005e6bd0 <.prevent_user_access.constprop.0>:
> 	c0000000005e7d8c:	4b ff ee 45 	bl      c0000000005e6bd0 <.prevent_user_access.constprop.0>
> 	c0000000007bcae0 <.prevent_user_access.constprop.0>:
> 	c0000000007bda10:	4b ff f0 d1 	bl      c0000000007bcae0 <.prevent_user_access.constprop.0>
> 	c0000000007bda54:	4b ff f0 8d 	bl      c0000000007bcae0 <.prevent_user_access.constprop.0>
> 	c0000000007bdd28:	4b ff ed b9 	bl      c0000000007bcae0 <.prevent_user_access.constprop.0>
> 	c0000000007c0390:	4b ff c7 51 	bl      c0000000007bcae0 <.prevent_user_access.constprop.0>
> 	c00000000094e4f0 <.prevent_user_access.constprop.0>:
> 	c000000000950e40:	4b ff d6 b1 	bl      c00000000094e4f0 <.prevent_user_access.constprop.0>
> 	c00000000097d2d0 <.prevent_user_access.constprop.0>:
> 	c0000000009813fc:	4b ff be d5 	bl      c00000000097d2d0 <.prevent_user_access.constprop.0>
> 	c000000000acd540 <.prevent_user_access.constprop.0>:
> 	c000000000ad1d60:	4b ff b7 e1 	bl      c000000000acd540 <.prevent_user_access.constprop.0>
> 	c000000000e5d680 <.prevent_user_access.constprop.0>:
> 	c000000000e64b60:	4b ff 8b 21 	bl      c000000000e5d680 <.prevent_user_access.constprop.0>
> 	c000000000e64b6c:	4b ff 8b 15 	bl      c000000000e5d680 <.prevent_user_access.constprop.0>
> 	c000000000e64c38:	4b ff 8a 49 	bl      c000000000e5d680 <.prevent_user_access.constprop.0>
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64: Force inlining of prevent_user_access() and set_kuap()
      https://git.kernel.org/powerpc/c/792993919349fefba20f58ae4843c80e8b01f518

cheers
