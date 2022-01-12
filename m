Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E248C44F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353315AbiALNAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:00:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37954 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240808AbiALNAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:00:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFAC76189A;
        Wed, 12 Jan 2022 13:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52B8C36AE5;
        Wed, 12 Jan 2022 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641992447;
        bh=QG1x1Wws3d6j6uD/KkS/vVr8OBRrM5QcCgXMtdOnUOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sNV2BFAZhBOvG8xvYAKzMD+injlbHPbMRZunxzAp3rXtOJ+FCPxwubA+K1g6Z15vz
         ZpaH4Nx+42DtTx4zguiBrhtdkMj1n7gweEpdUcpyX72oqow9yIZCknDMMCSeM0l6fm
         VM4q6hEGkFOcdo/y0DSPY8KjT7i1Rd7yzdj+P3/Tphb+qJNvJm3Y4svQCeS6le2Q+w
         FbXZmd6KdWyTS8MjMq7sLwdXH1FunFMoF0mqPICUneyJztc795GfvzuYWNxM5Gf+B6
         4e2pHcY2i5CN1+E89hz+mfR0VR8trfYCHGCvCSBQ3wcizlpv7wUFWW2CT2fawZGDGI
         KocJRVvlO+X0Q==
Date:   Wed, 12 Jan 2022 21:00:38 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdnsp: remove not used variables
Message-ID: <20220112130038.GD3796@Peter>
References: <20220111085934.44844-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111085934.44844-1-pawell@gli-login.cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-11 09:59:34, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> Patch removes not used variables:
>  - ret from cdnsp_decode_trb function
>  - temp_64 from cdnsp_run function
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Reviewed-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/cdns3/cdnsp-debug.h  | 287 +++++++++++++++----------------
>  drivers/usb/cdns3/cdnsp-gadget.c |   3 -
>  2 files changed, 138 insertions(+), 152 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
> index a8776df2d4e0..29f3cf7ddbaa 100644
> --- a/drivers/usb/cdns3/cdnsp-debug.h
> +++ b/drivers/usb/cdns3/cdnsp-debug.h
> @@ -182,206 +182,195 @@ static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
>  	int ep_id = TRB_TO_EP_INDEX(field3) - 1;
>  	int type = TRB_FIELD_TO_TYPE(field3);
>  	unsigned int ep_num;
> -	int ret = 0;
>  	u32 temp;
>  
>  	ep_num = DIV_ROUND_UP(ep_id, 2);
>  
>  	switch (type) {
>  	case TRB_LINK:
> -		ret += snprintf(str, size,
> -				"LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
> -				field1, field0, GET_INTR_TARGET(field2),
> -				cdnsp_trb_type_string(type),
> -				field3 & TRB_IOC ? 'I' : 'i',
> -				field3 & TRB_CHAIN ? 'C' : 'c',
> -				field3 & TRB_TC ? 'T' : 't',
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size,
> +			 "LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
> +			 field1, field0, GET_INTR_TARGET(field2),
> +			 cdnsp_trb_type_string(type),
> +			 field3 & TRB_IOC ? 'I' : 'i',
> +			 field3 & TRB_CHAIN ? 'C' : 'c',
> +			 field3 & TRB_TC ? 'T' : 't',
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_TRANSFER:
>  	case TRB_COMPLETION:
>  	case TRB_PORT_STATUS:
>  	case TRB_HC_EVENT:
> -		ret += snprintf(str, size,
> -				"ep%d%s(%d) type '%s' TRB %08x%08x status '%s'"
> -				" len %ld slot %ld flags %c:%c",
> -				ep_num, ep_id % 2 ? "out" : "in",
> -				TRB_TO_EP_INDEX(field3),
> -				cdnsp_trb_type_string(type), field1, field0,
> -				cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
> -				EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
> -				field3 & EVENT_DATA ? 'E' : 'e',
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size, "ep%d%s(%d) type '%s' TRB %08x%08x"
> +			 " status '%s' len %ld slot %ld flags %c:%c",
> +			 ep_num, ep_id % 2 ? "out" : "in",
> +			 TRB_TO_EP_INDEX(field3),
> +			 cdnsp_trb_type_string(type), field1, field0,
> +			 cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
> +			 EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
> +			 field3 & EVENT_DATA ? 'E' : 'e',
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_MFINDEX_WRAP:
> -		ret += snprintf(str, size, "%s: flags %c",
> -				cdnsp_trb_type_string(type),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size, "%s: flags %c",
> +			 cdnsp_trb_type_string(type),
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_SETUP:
> -		ret += snprintf(str, size,
> -				"type '%s' bRequestType %02x bRequest %02x "
> -				"wValue %02x%02x wIndex %02x%02x wLength %d "
> -				"length %ld TD size %ld intr %ld Setup ID %ld "
> -				"flags %c:%c:%c",
> -				cdnsp_trb_type_string(type),
> -				field0 & 0xff,
> -				(field0 & 0xff00) >> 8,
> -				(field0 & 0xff000000) >> 24,
> -				(field0 & 0xff0000) >> 16,
> -				(field1 & 0xff00) >> 8,
> -				field1 & 0xff,
> -				(field1 & 0xff000000) >> 16 |
> -				(field1 & 0xff0000) >> 16,
> -				TRB_LEN(field2), GET_TD_SIZE(field2),
> -				GET_INTR_TARGET(field2),
> -				TRB_SETUPID_TO_TYPE(field3),
> -				field3 & TRB_IDT ? 'D' : 'd',
> -				field3 & TRB_IOC ? 'I' : 'i',
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size, "type '%s' bRequestType %02x "
> +			 "bRequest %02x wValue %02x%02x wIndex %02x%02x "
> +			 "wLength %d length %ld TD size %ld intr %ld "
> +			 "Setup ID %ld flags %c:%c:%c",
> +			 cdnsp_trb_type_string(type),
> +			 field0 & 0xff,
> +			 (field0 & 0xff00) >> 8,
> +			 (field0 & 0xff000000) >> 24,
> +			 (field0 & 0xff0000) >> 16,
> +			 (field1 & 0xff00) >> 8,
> +			 field1 & 0xff,
> +			 (field1 & 0xff000000) >> 16 |
> +			 (field1 & 0xff0000) >> 16,
> +			 TRB_LEN(field2), GET_TD_SIZE(field2),
> +			 GET_INTR_TARGET(field2),
> +			 TRB_SETUPID_TO_TYPE(field3),
> +			 field3 & TRB_IDT ? 'D' : 'd',
> +			 field3 & TRB_IOC ? 'I' : 'i',
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_DATA:
> -		ret += snprintf(str, size,
> -				"type '%s' Buffer %08x%08x length %ld TD size %ld "
> -				"intr %ld flags %c:%c:%c:%c:%c:%c:%c",
> -				cdnsp_trb_type_string(type),
> -				field1, field0, TRB_LEN(field2),
> -				GET_TD_SIZE(field2),
> -				GET_INTR_TARGET(field2),
> -				field3 & TRB_IDT ? 'D' : 'i',
> -				field3 & TRB_IOC ? 'I' : 'i',
> -				field3 & TRB_CHAIN ? 'C' : 'c',
> -				field3 & TRB_NO_SNOOP ? 'S' : 's',
> -				field3 & TRB_ISP ? 'I' : 'i',
> -				field3 & TRB_ENT ? 'E' : 'e',
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size, "type '%s' Buffer %08x%08x length %ld "
> +			 "TD size %ld intr %ld flags %c:%c:%c:%c:%c:%c:%c",
> +			 cdnsp_trb_type_string(type),
> +			 field1, field0, TRB_LEN(field2),
> +			 GET_TD_SIZE(field2),
> +			 GET_INTR_TARGET(field2),
> +			 field3 & TRB_IDT ? 'D' : 'i',
> +			 field3 & TRB_IOC ? 'I' : 'i',
> +			 field3 & TRB_CHAIN ? 'C' : 'c',
> +			 field3 & TRB_NO_SNOOP ? 'S' : 's',
> +			 field3 & TRB_ISP ? 'I' : 'i',
> +			 field3 & TRB_ENT ? 'E' : 'e',
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_STATUS:
> -		ret += snprintf(str, size,
> -				"Buffer %08x%08x length %ld TD size %ld intr"
> -				"%ld type '%s' flags %c:%c:%c:%c",
> -				field1, field0, TRB_LEN(field2),
> -				GET_TD_SIZE(field2),
> -				GET_INTR_TARGET(field2),
> -				cdnsp_trb_type_string(type),
> -				field3 & TRB_IOC ? 'I' : 'i',
> -				field3 & TRB_CHAIN ? 'C' : 'c',
> -				field3 & TRB_ENT ? 'E' : 'e',
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size, "Buffer %08x%08x length %ld TD size %ld"
> +			 " intr %ld type '%s' flags %c:%c:%c:%c",
> +			 field1, field0, TRB_LEN(field2),
> +			 GET_TD_SIZE(field2),
> +			 GET_INTR_TARGET(field2),
> +			 cdnsp_trb_type_string(type),
> +			 field3 & TRB_IOC ? 'I' : 'i',
> +			 field3 & TRB_CHAIN ? 'C' : 'c',
> +			 field3 & TRB_ENT ? 'E' : 'e',
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_NORMAL:
>  	case TRB_ISOC:
>  	case TRB_EVENT_DATA:
>  	case TRB_TR_NOOP:
> -		ret += snprintf(str, size,
> -				"type '%s' Buffer %08x%08x length %ld "
> -				"TD size %ld intr %ld "
> -				"flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
> -				cdnsp_trb_type_string(type),
> -				field1, field0, TRB_LEN(field2),
> -				GET_TD_SIZE(field2),
> -				GET_INTR_TARGET(field2),
> -				field3 & TRB_BEI ? 'B' : 'b',
> -				field3 & TRB_IDT ? 'T' : 't',
> -				field3 & TRB_IOC ? 'I' : 'i',
> -				field3 & TRB_CHAIN ? 'C' : 'c',
> -				field3 & TRB_NO_SNOOP ? 'S' : 's',
> -				field3 & TRB_ISP ? 'I' : 'i',
> -				field3 & TRB_ENT ? 'E' : 'e',
> -				field3 & TRB_CYCLE ? 'C' : 'c',
> -				!(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
> +		snprintf(str, size, "type '%s' Buffer %08x%08x length %ld "
> +			 "TD size %ld intr %ld "
> +			 "flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
> +			 cdnsp_trb_type_string(type),
> +			 field1, field0, TRB_LEN(field2),
> +			 GET_TD_SIZE(field2),
> +			 GET_INTR_TARGET(field2),
> +			 field3 & TRB_BEI ? 'B' : 'b',
> +			 field3 & TRB_IDT ? 'T' : 't',
> +			 field3 & TRB_IOC ? 'I' : 'i',
> +			 field3 & TRB_CHAIN ? 'C' : 'c',
> +			 field3 & TRB_NO_SNOOP ? 'S' : 's',
> +			 field3 & TRB_ISP ? 'I' : 'i',
> +			 field3 & TRB_ENT ? 'E' : 'e',
> +			 field3 & TRB_CYCLE ? 'C' : 'c',
> +			 !(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
>  		break;
>  	case TRB_CMD_NOOP:
>  	case TRB_ENABLE_SLOT:
> -		ret += snprintf(str, size, "%s: flags %c",
> -				cdnsp_trb_type_string(type),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size, "%s: flags %c",
> +			 cdnsp_trb_type_string(type),
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_DISABLE_SLOT:
> -		ret += snprintf(str, size, "%s: slot %ld flags %c",
> -				cdnsp_trb_type_string(type),
> -				TRB_TO_SLOT_ID(field3),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size, "%s: slot %ld flags %c",
> +			 cdnsp_trb_type_string(type),
> +			 TRB_TO_SLOT_ID(field3),
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_ADDR_DEV:
> -		ret += snprintf(str, size,
> -				"%s: ctx %08x%08x slot %ld flags %c:%c",
> -				cdnsp_trb_type_string(type), field1, field0,
> -				TRB_TO_SLOT_ID(field3),
> -				field3 & TRB_BSR ? 'B' : 'b',
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size, "%s: ctx %08x%08x slot %ld flags %c:%c",
> +			 cdnsp_trb_type_string(type), field1, field0,
> +			 TRB_TO_SLOT_ID(field3),
> +			 field3 & TRB_BSR ? 'B' : 'b',
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_CONFIG_EP:
> -		ret += snprintf(str, size,
> -				"%s: ctx %08x%08x slot %ld flags %c:%c",
> -				cdnsp_trb_type_string(type), field1, field0,
> -				TRB_TO_SLOT_ID(field3),
> -				field3 & TRB_DC ? 'D' : 'd',
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size, "%s: ctx %08x%08x slot %ld flags %c:%c",
> +			 cdnsp_trb_type_string(type), field1, field0,
> +			 TRB_TO_SLOT_ID(field3),
> +			 field3 & TRB_DC ? 'D' : 'd',
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_EVAL_CONTEXT:
> -		ret += snprintf(str, size,
> -				"%s: ctx %08x%08x slot %ld flags %c",
> -				cdnsp_trb_type_string(type), field1, field0,
> -				TRB_TO_SLOT_ID(field3),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size, "%s: ctx %08x%08x slot %ld flags %c",
> +			 cdnsp_trb_type_string(type), field1, field0,
> +			 TRB_TO_SLOT_ID(field3),
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_RESET_EP:
>  	case TRB_HALT_ENDPOINT:
>  	case TRB_FLUSH_ENDPOINT:
> -		ret += snprintf(str, size,
> -				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
> -				cdnsp_trb_type_string(type),
> -				ep_num, ep_id % 2 ? "out" : "in",
> -				TRB_TO_EP_INDEX(field3), field1, field0,
> -				TRB_TO_SLOT_ID(field3),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size,
> +			 "%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
> +			 cdnsp_trb_type_string(type),
> +			 ep_num, ep_id % 2 ? "out" : "in",
> +			 TRB_TO_EP_INDEX(field3), field1, field0,
> +			 TRB_TO_SLOT_ID(field3),
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_STOP_RING:
> -		ret += snprintf(str, size,
> -				"%s: ep%d%s(%d) slot %ld sp %d flags %c",
> -				cdnsp_trb_type_string(type),
> -				ep_num, ep_id % 2 ? "out" : "in",
> -				TRB_TO_EP_INDEX(field3),
> -				TRB_TO_SLOT_ID(field3),
> -				TRB_TO_SUSPEND_PORT(field3),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size, "%s: ep%d%s(%d) slot %ld sp %d flags %c",
> +			 cdnsp_trb_type_string(type),
> +			 ep_num, ep_id % 2 ? "out" : "in",
> +			 TRB_TO_EP_INDEX(field3),
> +			 TRB_TO_SLOT_ID(field3),
> +			 TRB_TO_SUSPEND_PORT(field3),
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_SET_DEQ:
> -		ret += snprintf(str, size,
> -				"%s: ep%d%s(%d) deq %08x%08x stream %ld slot %ld  flags %c",
> -				cdnsp_trb_type_string(type),
> -				ep_num, ep_id % 2 ? "out" : "in",
> -				TRB_TO_EP_INDEX(field3), field1, field0,
> -				TRB_TO_STREAM_ID(field2),
> -				TRB_TO_SLOT_ID(field3),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size, "%s: ep%d%s(%d) deq %08x%08x stream %ld"
> +			 " slot %ld  flags %c",
> +			 cdnsp_trb_type_string(type),
> +			 ep_num, ep_id % 2 ? "out" : "in",
> +			 TRB_TO_EP_INDEX(field3), field1, field0,
> +			 TRB_TO_STREAM_ID(field2),
> +			 TRB_TO_SLOT_ID(field3),
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_RESET_DEV:
> -		ret += snprintf(str, size, "%s: slot %ld flags %c",
> -				cdnsp_trb_type_string(type),
> -				TRB_TO_SLOT_ID(field3),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size, "%s: slot %ld flags %c",
> +			 cdnsp_trb_type_string(type),
> +			 TRB_TO_SLOT_ID(field3),
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_ENDPOINT_NRDY:
>  		temp  = TRB_TO_HOST_STREAM(field2);
>  
> -		ret += snprintf(str, size,
> -				"%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
> -				cdnsp_trb_type_string(type),
> -				ep_num, ep_id % 2 ? "out" : "in",
> -				TRB_TO_EP_INDEX(field3), temp,
> -				temp == STREAM_PRIME_ACK ? "(PRIME)" : "",
> -				temp == STREAM_REJECTED ? "(REJECTED)" : "",
> -				TRB_TO_DEV_STREAM(field0),
> -				field3 & TRB_STAT ? 'S' : 's',
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		snprintf(str, size,
> +			 "%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
> +			 cdnsp_trb_type_string(type),
> +			 ep_num, ep_id % 2 ? "out" : "in",
> +			 TRB_TO_EP_INDEX(field3), temp,
> +			 temp == STREAM_PRIME_ACK ? "(PRIME)" : "",
> +			 temp == STREAM_REJECTED ? "(REJECTED)" : "",
> +			 TRB_TO_DEV_STREAM(field0),
> +			 field3 & TRB_STAT ? 'S' : 's',
> +			 field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	default:
> -		ret += snprintf(str, size,
> -				"type '%s' -> raw %08x %08x %08x %08x",
> -				cdnsp_trb_type_string(type),
> -				field0, field1, field2, field3);
> +		snprintf(str, size, "type '%s' -> raw %08x %08x %08x %08x",
> +			 cdnsp_trb_type_string(type),
> +			 field0, field1, field2, field3);
>  	}
>  
>  	return str;
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index 27df0c697897..ec8a0dc792bc 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -1243,12 +1243,9 @@ static int cdnsp_run(struct cdnsp_device *pdev,
>  		     enum usb_device_speed speed)
>  {
>  	u32 fs_speed = 0;
> -	u64 temp_64;
>  	u32 temp;
>  	int ret;
>  
> -	temp_64 = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
> -	temp_64 &= ~ERST_PTR_MASK;
>  	temp = readl(&pdev->ir_set->irq_control);
>  	temp &= ~IMOD_INTERVAL_MASK;
>  	temp |= ((IMOD_DEFAULT_INTERVAL / 250) & IMOD_INTERVAL_MASK);
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen

