Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AB75122BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiD0TbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiD0TbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94D314B43C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651087622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8WAoChBSaZGQGR5mebDk3D5BL8qd1xvhTMspSlXtCQc=;
        b=KPUDzGPWYuBjha2YzHnHXTINO+2Hp1wDEkagH91KF764icnu4O+WnKzx/Z0ApkdEFeM5wZ
        jxsWLPnarR4ex1gib3QWGJbC3orl2AggZOSbML2MeqQIuhk94xnMSUchREauRh1v/mykzo
        CmpTGYF0f/tvu+IGl3wZYTd8jsAaszs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-DDC-NOr5Omm3Ugnaj3Eotw-1; Wed, 27 Apr 2022 15:27:00 -0400
X-MC-Unique: DDC-NOr5Omm3Ugnaj3Eotw-1
Received: by mail-qk1-f197.google.com with SMTP id q12-20020ae9e40c000000b0069f091022dbso1810905qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8WAoChBSaZGQGR5mebDk3D5BL8qd1xvhTMspSlXtCQc=;
        b=jr239YT9l0BK823o3FrUh1u8RXgWGRqX9ZHZXTe1sfSycgvDXaGxPppdjvT64YRf8b
         V9c7Wd44W+xyClXJa9Gk5GMdhr4IqiL065OtKpQDJuOI/Fn7iD3cQEfc9r89FjnYR7en
         g9cOE43cuYNnIPDW/vh1Vm+AFXsNTy8bLsFvRzz8UAHx1mcYY5xCvB9kWHPlAiG8JbE1
         omMzUtCLVQWvQ8bMR129wToJQ9gk1aGegCZ6hPLy7gUI7Zgzs6dWNImdRY5n+PXJXOOk
         bMFdEDgSPZ78rVvq8SJq7P9+INCODV3sujSlzTXjv2xDmFrONUER8eZJGvKutCJnYDSg
         g9ow==
X-Gm-Message-State: AOAM533TU3gBtA/pwn8rXEGm9KjZLVVM1vHo9F931/YpxjAKn6zR8SL0
        lHxRLoCzeNcIl7DtJocHq+xI3Sk1dXXUHuJb4Dglrhxtb/y8fJOSKMkOBMnzSIeh6zhU6tEMqxS
        xz3YWCQgK4Zgrai7BHhA37Bcz
X-Received: by 2002:a05:6214:252b:b0:456:3c2b:c910 with SMTP id gg11-20020a056214252b00b004563c2bc910mr10202037qvb.85.1651087619326;
        Wed, 27 Apr 2022 12:26:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc0xyQRHQQrYPbhNmmirFuUuwf6riBgvsumaJBrw8wUc7zsVs+fk7NOTdY3m0UHwkXgfeC4g==
X-Received: by 2002:a05:6214:252b:b0:456:3c2b:c910 with SMTP id gg11-20020a056214252b00b004563c2bc910mr10202007qvb.85.1651087618937;
        Wed, 27 Apr 2022 12:26:58 -0700 (PDT)
Received: from loberman.users.ipa.redhat.com ([2600:6c64:4e7f:cee0:729d:61b6:700c:6b56])
        by smtp.gmail.com with ESMTPSA id 9-20020a05620a070900b0069e60da45aasm8188993qkc.60.2022.04.27.12.26.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2022 12:26:58 -0700 (PDT)
Message-ID: <ae63bff76f384ad7d28aa0833beba6860171aea9.camel@redhat.com>
Subject: Re: [PATCH] target: pscsi: set SCF_TREAT_READ_AS_NORMAL flag only
 if there is valid data
From:   Laurence Oberman <loberman@redhat.com>
To:     David Jeffery <djeffery@redhat.com>, target-devel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 27 Apr 2022 15:26:56 -0400
In-Reply-To: <20220427183250.291881-1-djeffery@redhat.com>
References: <20220427183250.291881-1-djeffery@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-27 at 14:32 -0400, David Jeffery wrote:
> With tape devices, the SCF_TREAT_READ_AS_NORMAL flag is used by the
> target
> subsystem to mark commands which have both data to return as well as
> sense data. But with pscsi, SCF_TREAT_READ_AS_NORMAL can be set even
> if
> there is no data to return. The SCF_TREAT_READ_AS_NORMAL flag causes
> the
> target core to call iscsit datain callbacks even if there is no data,
> which
> iscsit does not support. This results in iscsit going into an error
> state
> requiring recovery and being unable to complete the command to the
> initiator.
> 
> This issue can be resolved by fixing pscsi to only set
> SCF_TREAT_READ_AS_NORMAL if there is valid data to return along side
> the
> sense data.
> 
> Fixes: bd81372065fa ("scsi: target: transport should handle st
> FM/EOM/ILI reads")
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>
> ---
>  drivers/target/target_core_pscsi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/target/target_core_pscsi.c
> b/drivers/target/target_core_pscsi.c
> index ff292b75e23f..60dafe4c581b 100644
> --- a/drivers/target/target_core_pscsi.c
> +++ b/drivers/target/target_core_pscsi.c
> @@ -588,7 +588,7 @@ static void pscsi_destroy_device(struct se_device
> *dev)
>  }
>  
>  static void pscsi_complete_cmd(struct se_cmd *cmd, u8 scsi_status,
> -			       unsigned char *req_sense)
> +			       unsigned char *req_sense, int
> valid_data)
>  {
>  	struct pscsi_dev_virt *pdv = PSCSI_DEV(cmd->se_dev);
>  	struct scsi_device *sd = pdv->pdv_sd;
> @@ -681,7 +681,7 @@ static void pscsi_complete_cmd(struct se_cmd
> *cmd, u8 scsi_status,
>  		 * back despite framework assumption that a
>  		 * check condition means there is no data
>  		 */
> -		if (sd->type == TYPE_TAPE &&
> +		if (sd->type == TYPE_TAPE && valid_data &&
>  		    cmd->data_direction == DMA_FROM_DEVICE) {
>  			/*
>  			 * is sense data valid, fixed format,
> @@ -1032,6 +1032,7 @@ static void pscsi_req_done(struct request *req,
> blk_status_t status)
>  	struct se_cmd *cmd = req->end_io_data;
>  	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
>  	enum sam_status scsi_status = scmd->result & 0xff;
> +	int valid_data = cmd->data_length - scmd->resid_len;
>  	u8 *cdb = cmd->priv;
>  
>  	if (scsi_status != SAM_STAT_GOOD) {
> @@ -1039,12 +1040,11 @@ static void pscsi_req_done(struct request
> *req, blk_status_t status)
>  			" 0x%02x Result: 0x%08x\n", cmd, cdb[0], scmd-
> >result);
>  	}
>  
> -	pscsi_complete_cmd(cmd, scsi_status, scmd->sense_buffer);
> +	pscsi_complete_cmd(cmd, scsi_status, scmd->sense_buffer,
> valid_data);
>  
>  	switch (host_byte(scmd->result)) {
>  	case DID_OK:
> -		target_complete_cmd_with_length(cmd, scsi_status,
> -			cmd->data_length - scmd->resid_len);
> +		target_complete_cmd_with_length(cmd, scsi_status,
> valid_data);
>  		break;
>  	default:
>  		pr_debug("PSCSI Host Byte exception at cmd: %p CDB:"

We added a bucnh of debug to track this down, and the fix is solid and
makes perfect sense.

Reviewed-by: Laurence Oberman <loberman@redhat.com>

