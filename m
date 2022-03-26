Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECED4E7E5D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 02:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiCZBLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 21:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiCZBLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:11:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF254170D95;
        Fri, 25 Mar 2022 18:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5917360DF2;
        Sat, 26 Mar 2022 01:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E89C2BBE4;
        Sat, 26 Mar 2022 01:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648257016;
        bh=/EPB57cC1yNq7t3sg76uoL4Idh0mWrldx4Mk1K/mK3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OM55TS0ZHEYo1QH7ZKJoH3h06Be0cvNDoNRJWx4xjrkBTSjYV8QO8+7WAQfaufUwL
         XGFKuiqBskYyWpcw9DRK5+fSRdeUmpFpNxXHTAeTMz24EIh+RUvkXZraRPndBUJiPD
         1zv7Wh9YL43sNKUIEU0hleyxU//8WW5IDIno4dIuJ+WiANLT0rKujOGASxK1ecx1zU
         GTxS2PUEYiibCzo0JbtYcz+Qf6vtKdP8k9bR0kG+pvcAdz7wbZNTDJzZijtpoTsasD
         bE+64NZ7Whd09JGCtXAy6Hq7FfKCvK0wMH8XtHzxBClbR7vag0fjYLk6Xr3LXlGd2c
         bnX4ALQxMgVoA==
Date:   Fri, 25 Mar 2022 20:19:25 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Robert Love <robert.w.love@intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] scsi: fcoe: Fix Wstringop-overflow warnings in
 fcoe_wwn_from_mac()
Message-ID: <20220326011925.GD2602091@embeddedor>
References: <20220303235521.GA1745589@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220303235521.GA1745589@embeddedor>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping: who can take this, please?

... I can take this in my -next tree, in the meantime.

Thanks
--
Gustavo

On Thu, Mar 03, 2022 at 05:55:21PM -0600, Gustavo A. R. Silva wrote:
> Fix the following Wstringop-overflow warnings when building with GCC-11:
> 
> drivers/scsi/fcoe/fcoe.c: In function ‘fcoe_netdev_config’:
> drivers/scsi/fcoe/fcoe.c:744:32: warning: ‘fcoe_wwn_from_mac’ accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
>   744 |                         wwnn = fcoe_wwn_from_mac(ctlr->ctl_src_addr, 1, 0);
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/fcoe/fcoe.c:744:32: note: referencing argument 1 of type ‘unsigned char *’
> In file included from drivers/scsi/fcoe/fcoe.c:36:
> ./include/scsi/libfcoe.h:252:5: note: in a call to function ‘fcoe_wwn_from_mac’
>   252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
>       |     ^~~~~~~~~~~~~~~~~
> drivers/scsi/fcoe/fcoe.c:747:32: warning: ‘fcoe_wwn_from_mac’ accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
>   747 |                         wwpn = fcoe_wwn_from_mac(ctlr->ctl_src_addr,
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   748 |                                                  2, 0);
>       |                                                  ~~~~~
> drivers/scsi/fcoe/fcoe.c:747:32: note: referencing argument 1 of type ‘unsigned char *’
> In file included from drivers/scsi/fcoe/fcoe.c:36:
> ./include/scsi/libfcoe.h:252:5: note: in a call to function ‘fcoe_wwn_from_mac’
>   252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
>       |     ^~~~~~~~~~~~~~~~~
>   CC      drivers/scsi/bnx2fc/bnx2fc_io.o
> In function ‘bnx2fc_net_config’,
>     inlined from ‘bnx2fc_if_create’ at drivers/scsi/bnx2fc/bnx2fc_fcoe.c:1543:7:
> drivers/scsi/bnx2fc/bnx2fc_fcoe.c:833:32: warning: ‘fcoe_wwn_from_mac’ accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
>   833 |                         wwnn = fcoe_wwn_from_mac(ctlr->ctl_src_addr,
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   834 |                                                  1, 0);
>       |                                                  ~~~~~
> drivers/scsi/bnx2fc/bnx2fc_fcoe.c: In function ‘bnx2fc_if_create’:
> drivers/scsi/bnx2fc/bnx2fc_fcoe.c:833:32: note: referencing argument 1 of type ‘unsigned char *’
> In file included from drivers/scsi/bnx2fc/bnx2fc.h:53,
>                  from drivers/scsi/bnx2fc/bnx2fc_fcoe.c:17:
> ./include/scsi/libfcoe.h:252:5: note: in a call to function ‘fcoe_wwn_from_mac’
>   252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
>       |     ^~~~~~~~~~~~~~~~~
> In function ‘bnx2fc_net_config’,
>     inlined from ‘bnx2fc_if_create’ at drivers/scsi/bnx2fc/bnx2fc_fcoe.c:1543:7:
> drivers/scsi/bnx2fc/bnx2fc_fcoe.c:839:32: warning: ‘fcoe_wwn_from_mac’ accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
>   839 |                         wwpn = fcoe_wwn_from_mac(ctlr->ctl_src_addr,
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   840 |                                                  2, 0);
>       |                                                  ~~~~~
> drivers/scsi/bnx2fc/bnx2fc_fcoe.c: In function ‘bnx2fc_if_create’:
> drivers/scsi/bnx2fc/bnx2fc_fcoe.c:839:32: note: referencing argument 1 of type ‘unsigned char *’
> In file included from drivers/scsi/bnx2fc/bnx2fc.h:53,
>                  from drivers/scsi/bnx2fc/bnx2fc_fcoe.c:17:
> ./include/scsi/libfcoe.h:252:5: note: in a call to function ‘fcoe_wwn_from_mac’
>   252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
>       |     ^~~~~~~~~~~~~~~~~
> drivers/scsi/qedf/qedf_main.c: In function ‘__qedf_probe’:
> drivers/scsi/qedf/qedf_main.c:3520:30: warning: ‘fcoe_wwn_from_mac’ accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
>  3520 |                 qedf->wwnn = fcoe_wwn_from_mac(qedf->mac, 1, 0);
>       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/qedf/qedf_main.c:3520:30: note: referencing argument 1 of type ‘unsigned char *’
> In file included from drivers/scsi/qedf/qedf.h:9,
>                  from drivers/scsi/qedf/qedf_main.c:23:
> ./include/scsi/libfcoe.h:252:5: note: in a call to function ‘fcoe_wwn_from_mac’
>   252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
>       |     ^~~~~~~~~~~~~~~~~
> drivers/scsi/qedf/qedf_main.c:3521:30: warning: ‘fcoe_wwn_from_mac’ accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
>  3521 |                 qedf->wwpn = fcoe_wwn_from_mac(qedf->mac, 2, 0);
>       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/qedf/qedf_main.c:3521:30: note: referencing argument 1 of type ‘unsigned char *’
> In file included from drivers/scsi/qedf/qedf.h:9,
>                  from drivers/scsi/qedf/qedf_main.c:23:
> ./include/scsi/libfcoe.h:252:5: note: in a call to function ‘fcoe_wwn_from_mac’
>   252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
>       |     ^~~~~~~~~~~~~~~~~
> 
> by changing the array size to the correct value of ETH_ALEN in the
> argument declaration.
> 
> Also, fix a couple of checkpatch warnings:
> WARNING: function definition argument 'unsigned int' should also have an identifier name
> 
> This helps with the ongoing efforts to globally enable
> -Wstringop-overflow.
> 
> Link: https://github.com/KSPP/linux/issues/181
> Fixes: 85b4aa4926a5 ("[SCSI] fcoe: Fibre Channel over Ethernet")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/scsi/fcoe/fcoe_ctlr.c | 2 +-
>  include/scsi/libfcoe.h        | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
> index 1756a0ac6f08..558f3f4e1859 100644
> --- a/drivers/scsi/fcoe/fcoe_ctlr.c
> +++ b/drivers/scsi/fcoe/fcoe_ctlr.c
> @@ -1969,7 +1969,7 @@ EXPORT_SYMBOL(fcoe_ctlr_recv_flogi);
>   *
>   * Returns: u64 fc world wide name
>   */
> -u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN],
> +u64 fcoe_wwn_from_mac(unsigned char mac[ETH_ALEN],
>  		      unsigned int scheme, unsigned int port)
>  {
>  	u64 wwn;
> diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
> index fac8e89aed81..310e0dbffda9 100644
> --- a/include/scsi/libfcoe.h
> +++ b/include/scsi/libfcoe.h
> @@ -249,7 +249,8 @@ int fcoe_ctlr_recv_flogi(struct fcoe_ctlr *, struct fc_lport *,
>  			 struct fc_frame *);
>  
>  /* libfcoe funcs */
> -u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
> +u64 fcoe_wwn_from_mac(unsigned char mac[ETH_ALEN], unsigned int scheme,
> +		      unsigned int port);
>  int fcoe_libfc_config(struct fc_lport *, struct fcoe_ctlr *,
>  		      const struct libfc_function_template *, int init_fcp);
>  u32 fcoe_fc_crc(struct fc_frame *fp);
> -- 
> 2.27.0
> 
