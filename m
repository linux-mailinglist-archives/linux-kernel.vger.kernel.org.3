Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126CD5ABDE7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 10:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiICIry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 04:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiICIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 04:47:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE11050061;
        Sat,  3 Sep 2022 01:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C0BA60FA7;
        Sat,  3 Sep 2022 08:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FBCC433C1;
        Sat,  3 Sep 2022 08:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662194870;
        bh=AKBx+RhnvYKvFKdZQt/dEcm891uO5Cn8M8h92FFEGTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHkhHl0uEUvytTxeXc1eeKQ+XoZ8DGypdOqQB/Dixpw976IgCju01fDH5B+VctrIB
         Ub3ROq0XcjWFl3TWoI01hphDuDeb0hUwPhVr0FLXSy+w7Zk3cVAaKnh9FPaXNRVGiR
         QKoBbvgB+60CGxJTmz895zb+8k4QHL+zRw6XsicolClCQG0egEFC3w4+lsjeT4uNTV
         ZvMbrjVfty+xhMGRIVSlLddwM7cJbu76ZtKjynWqonYii3wmBrP3GpTtAilEZG8FE7
         LxDYZ37R6uwj56vpQgHjMct3dBEK2sdfq3HQ9ir9WRLG7glVe4TSM2l4n989zQbVYT
         GxjdBSnAsgFFQ==
Date:   Sat, 3 Sep 2022 09:47:44 +0100
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Bradley Grove <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] esas2r: Use flex array destination for memcpy()
Message-ID: <YxMUsGW0ZYt9rmKd@work>
References: <20220901205729.2260982-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901205729.2260982-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 01:57:29PM -0700, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing run-time destination buffer
> bounds checking for memcpy(), specify the destination output buffer
> explicitly, instead of asking memcpy() to write past the end of what
> looked like a fixed-size object. Silences future run-time warning:
> 
>   memcpy: detected field-spanning write (size 80) of single field "trc + 1" (size 64)
> 
> There is no binary code output differences from this change.
> 
> Cc: Bradley Grove <linuxdrivers@attotech.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/scsi/esas2r/atioctl.h      | 1 +
>  drivers/scsi/esas2r/esas2r_ioctl.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/esas2r/atioctl.h b/drivers/scsi/esas2r/atioctl.h
> index ff2ad9b38575..dd3437412ffc 100644
> --- a/drivers/scsi/esas2r/atioctl.h
> +++ b/drivers/scsi/esas2r/atioctl.h
> @@ -831,6 +831,7 @@ struct __packed atto_hba_trace {
>  	u32 total_length;
>  	u32 trace_mask;
>  	u8 reserved2[48];
> +	u8 contents[];
>  };
>  
>  #define ATTO_FUNC_SCSI_PASS_THRU     0x04
> diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
> index 08f4e43c7d9e..e003d923acbf 100644
> --- a/drivers/scsi/esas2r/esas2r_ioctl.c
> +++ b/drivers/scsi/esas2r/esas2r_ioctl.c
> @@ -947,10 +947,9 @@ static int hba_ioctl_callback(struct esas2r_adapter *a,
>  					break;
>  				}
>  
> -				memcpy(trc + 1,
> +				memcpy(trc->contents,
>  				       a->fw_coredump_buff + offset,
>  				       len);
> -
>  				hi->data_length = len;
>  			} else if (trc->trace_func == ATTO_TRC_TF_RESET) {
>  				memset(a->fw_coredump_buff, 0,
> -- 
> 2.34.1
> 
