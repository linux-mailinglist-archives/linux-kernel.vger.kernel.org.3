Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333334E866F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 09:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiC0HLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 03:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiC0HLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 03:11:04 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEE11D0F3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 00:09:25 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KR6QD0M1Gz9sSV;
        Sun, 27 Mar 2022 09:09:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jAtWlDOuK_I6; Sun, 27 Mar 2022 09:09:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KR6QC6f3jz9sSS;
        Sun, 27 Mar 2022 09:09:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D26048B768;
        Sun, 27 Mar 2022 09:09:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yI8LRLGcX_Nj; Sun, 27 Mar 2022 09:09:23 +0200 (CEST)
Received: from [192.168.204.35] (unknown [192.168.204.35])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 586548B763;
        Sun, 27 Mar 2022 09:09:23 +0200 (CEST)
Message-ID: <6adcc6f5-cd72-e455-16a9-0d9a454127d2@csgroup.eu>
Date:   Sun, 27 Mar 2022 09:09:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/5] powerpc/83xx: fix possible object reference leak
Content-Language: fr-FR
To:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Scott Wood <oss@buserror.net>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <1553223955-7350-1-git-send-email-wen.yang99@zte.com.cn>
 <1553223955-7350-2-git-send-email-wen.yang99@zte.com.cn>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <1553223955-7350-2-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/03/2019 à 04:05, Wen Yang a écrit :
> The call to of_find_node_by_name returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./arch/powerpc/platforms/83xx/km83xx.c:68:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 59, but without a corresponding object release within this function.

This was fixed by 
https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=88654d5b4476

> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/powerpc/platforms/83xx/km83xx.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
> index d8642a4..11eea7c 100644
> --- a/arch/powerpc/platforms/83xx/km83xx.c
> +++ b/arch/powerpc/platforms/83xx/km83xx.c
> @@ -65,6 +65,7 @@ static void quirk_mpc8360e_qe_enet10(void)
>   	ret = of_address_to_resource(np_par, 0, &res);
>   	if (ret) {
>   		pr_warn("%s couldn;t map par_io registers\n", __func__);
> +		of_node_put(np_par);
>   		return;
>   	}
>   
