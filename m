Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA8590B53
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 06:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiHLEwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 00:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiHLEwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 00:52:07 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513DC11A1A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 21:52:05 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id MMeQoMXpzAOp2MMeRohJUk; Fri, 12 Aug 2022 06:52:03 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 12 Aug 2022 06:52:03 +0200
X-ME-IP: 90.11.190.129
Message-ID: <f5210302-13b4-a9a2-8b69-469f7d68e370@wanadoo.fr>
Date:   Fri, 12 Aug 2022 06:52:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scsi: target: Save a few cycles in
 'transport_lookup_[cmd|tmr]_lun()'
Content-Language: en-US
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <e4a21bc607c39935cb98d4825cd63ba349820550.1635974637.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <e4a21bc607c39935cb98d4825cd63ba349820550.1635974637.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/11/2021 à 22:24, Christophe JAILLET a écrit :
> Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
> save a few cycles when it is known that the rcu lock is already
> taken/released.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/target/target_core_device.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
> index 44bb380e7390..bfd5d5606522 100644
> --- a/drivers/target/target_core_device.c
> +++ b/drivers/target/target_core_device.c
> @@ -77,7 +77,7 @@ transport_lookup_cmd_lun(struct se_cmd *se_cmd)
>   
>   		se_lun = rcu_dereference(deve->se_lun);
>   
> -		if (!percpu_ref_tryget_live(&se_lun->lun_ref)) {
> +		if (!percpu_ref_tryget_live_rcu(&se_lun->lun_ref)) {
>   			se_lun = NULL;
>   			goto out_unlock;
>   		}
> @@ -154,7 +154,7 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd)
>   	if (deve) {
>   		se_lun = rcu_dereference(deve->se_lun);
>   
> -		if (!percpu_ref_tryget_live(&se_lun->lun_ref)) {
> +		if (!percpu_ref_tryget_live_rcu(&se_lun->lun_ref)) {
>   			se_lun = NULL;
>   			goto out_unlock;
>   		}

Hi,
gentle reminder.

Is this patch useful?
When I first posted it, percpu_ref_tryget_live_rcu() was really new.
Now it is part of linux since 5.16.

Saving a few cycles in a function with "lookup" in its name looks always 
good to me.

CJ
