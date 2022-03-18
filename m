Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314E94DDF99
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbiCRRIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiCRRIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:08:39 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DC730DC62
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:07:19 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KKr6G1H8xz9sSK;
        Fri, 18 Mar 2022 18:07:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vOU920Q058wl; Fri, 18 Mar 2022 18:07:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KKr6G0Wssz9sRw;
        Fri, 18 Mar 2022 18:07:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 008608B78D;
        Fri, 18 Mar 2022 18:07:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DroGydVWazWJ; Fri, 18 Mar 2022 18:07:17 +0100 (CET)
Received: from [192.168.202.177] (unknown [192.168.202.177])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 93D838B767;
        Fri, 18 Mar 2022 18:07:17 +0100 (CET)
Message-ID: <0fcfca14-1096-c7fb-b174-b4eabbb18b9f@csgroup.eu>
Date:   Fri, 18 Mar 2022 18:07:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] macintosh: windfarm: Use NULL to compare with
 pointer-typed value rather than 0
Content-Language: fr-FR
To:     Xu Wang <vulab@iscas.ac.cn>, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20201113073343.64378-1-vulab@iscas.ac.cn>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20201113073343.64378-1-vulab@iscas.ac.cn>
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



Le 13/11/2020 à 08:33, Xu Wang a écrit :
> Compare pointer-typed values to NULL rather than 0.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

If we are going to change that, let's do it right at once

Checkpatch says:

CHECK: Comparison to NULL could be written "!hdr"
#25: FILE: drivers/macintosh/windfarm_pm121.c:653:
+	if (hdr == NULL) {

CHECK: Comparison to NULL could be written "hdr"
#34: FILE: drivers/macintosh/windfarm_pm121.c:972:
+	if (hdr != NULL) {

total: 0 errors, 0 warnings, 2 checks, 16 lines checked



> ---
>   drivers/macintosh/windfarm_pm121.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/macintosh/windfarm_pm121.c b/drivers/macintosh/windfarm_pm121.c
> index ab467b9c31be..62826844b584 100644
> --- a/drivers/macintosh/windfarm_pm121.c
> +++ b/drivers/macintosh/windfarm_pm121.c
> @@ -650,7 +650,7 @@ static void pm121_create_cpu_fans(void)
>   
>   	/* First, locate the PID params in SMU SBD */
>   	hdr = smu_get_sdb_partition(SMU_SDB_CPUPIDDATA_ID, NULL);
> -	if (hdr == 0) {
> +	if (hdr == NULL) {
>   		printk(KERN_WARNING "pm121: CPU PID fan config not found.\n");
>   		goto fail;
>   	}
> @@ -969,7 +969,7 @@ static int pm121_init_pm(void)
>   	const struct smu_sdbp_header *hdr;
>   
>   	hdr = smu_get_sdb_partition(SMU_SDB_SENSORTREE_ID, NULL);
> -	if (hdr != 0) {
> +	if (hdr != NULL) {
>   		struct smu_sdbp_sensortree *st =
>   			(struct smu_sdbp_sensortree *)&hdr[1];
>   		pm121_mach_model = st->model_id;
