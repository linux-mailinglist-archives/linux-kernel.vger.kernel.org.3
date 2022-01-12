Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167A848BED5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351126AbiALHIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:08:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37840 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbiALHIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:08:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF689B818BD;
        Wed, 12 Jan 2022 07:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7E8C36AEA;
        Wed, 12 Jan 2022 07:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641971327;
        bh=ylhUW6fupihicWd+vC33eQO9Dp1JqVxR/DruDtT7DXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQnos3BfGnzkQTPOHtnHACkMC8Ia/O+rGKjBZG9zbx/LAPC/ZUPXdxkpOAyOgRZ8Z
         vIRJwkAf/d9SK5ZX2SwGS7NKO/nihkQj03E5m446xY/WvsBfE3IvQEdRpI5GvBgVBR
         KEUhq2V/IaFsIr7qctEII+Hgm51J8HzUIdx5EK0c=
Date:   Wed, 12 Jan 2022 08:08:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     peter.chen@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdnsp: fix cdnsp_decode_trb function to properly
 handle ret value
Message-ID: <Yd5+fIlG+vhzBm4T@kroah.com>
References: <20220112053237.14309-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112053237.14309-1-pawell@gli-login.cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 06:32:37AM +0100, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> Variable ret in function cdnsp_decode_trb is initialized but not
> used. To fix this compiler warning patch adds checking whether the
> data buffer has not been overflowed.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/cdnsp-debug.h | 305 ++++++++++++++++----------------
>  1 file changed, 154 insertions(+), 151 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
> index a8776df2d4e0..f0ca865cce2a 100644
> --- a/drivers/usb/cdns3/cdnsp-debug.h
> +++ b/drivers/usb/cdns3/cdnsp-debug.h
> @@ -182,208 +182,211 @@ static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
>  	int ep_id = TRB_TO_EP_INDEX(field3) - 1;
>  	int type = TRB_FIELD_TO_TYPE(field3);
>  	unsigned int ep_num;
> -	int ret = 0;
> +	int ret;
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
> +		ret = snprintf(str, size,
> +			       "LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
> +			       field1, field0, GET_INTR_TARGET(field2),
> +			       cdnsp_trb_type_string(type),
> +			       field3 & TRB_IOC ? 'I' : 'i',
> +			       field3 & TRB_CHAIN ? 'C' : 'c',
> +			       field3 & TRB_TC ? 'T' : 't',
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
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
> +		ret = snprintf(str, size,
> +			       "ep%d%s(%d) type '%s' TRB %08x%08x status '%s'"
> +			       " len %ld slot %ld flags %c:%c",
> +			       ep_num, ep_id % 2 ? "out" : "in",
> +			       TRB_TO_EP_INDEX(field3),
> +			       cdnsp_trb_type_string(type), field1, field0,
> +			       cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
> +			       EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
> +			       field3 & EVENT_DATA ? 'E' : 'e',
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_MFINDEX_WRAP:
> -		ret += snprintf(str, size, "%s: flags %c",
> -				cdnsp_trb_type_string(type),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		ret = snprintf(str, size, "%s: flags %c",
> +			       cdnsp_trb_type_string(type),
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
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
> +		ret = snprintf(str, size,
> +			       "type '%s' bRequestType %02x bRequest %02x "
> +			       "wValue %02x%02x wIndex %02x%02x wLength %d "
> +			       "length %ld TD size %ld intr %ld Setup ID %ld "
> +			       "flags %c:%c:%c",
> +			       cdnsp_trb_type_string(type),
> +			       field0 & 0xff,
> +			       (field0 & 0xff00) >> 8,
> +			       (field0 & 0xff000000) >> 24,
> +			       (field0 & 0xff0000) >> 16,
> +			       (field1 & 0xff00) >> 8,
> +			       field1 & 0xff,
> +			       (field1 & 0xff000000) >> 16 |
> +			       (field1 & 0xff0000) >> 16,
> +			       TRB_LEN(field2), GET_TD_SIZE(field2),
> +			       GET_INTR_TARGET(field2),
> +			       TRB_SETUPID_TO_TYPE(field3),
> +			       field3 & TRB_IDT ? 'D' : 'd',
> +			       field3 & TRB_IOC ? 'I' : 'i',
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
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
> +		ret = snprintf(str, size,
> +			       "type '%s' Buffer %08x%08x length %ld TD size %ld "
> +			       "intr %ld flags %c:%c:%c:%c:%c:%c:%c",
> +			       cdnsp_trb_type_string(type),
> +			       field1, field0, TRB_LEN(field2),
> +			       GET_TD_SIZE(field2),
> +			       GET_INTR_TARGET(field2),
> +			       field3 & TRB_IDT ? 'D' : 'i',
> +			       field3 & TRB_IOC ? 'I' : 'i',
> +			       field3 & TRB_CHAIN ? 'C' : 'c',
> +			       field3 & TRB_NO_SNOOP ? 'S' : 's',
> +			       field3 & TRB_ISP ? 'I' : 'i',
> +			       field3 & TRB_ENT ? 'E' : 'e',
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
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
> +		ret = snprintf(str, size,
> +			       "Buffer %08x%08x length %ld TD size %ld intr"
> +			       "%ld type '%s' flags %c:%c:%c:%c",
> +			       field1, field0, TRB_LEN(field2),
> +			       GET_TD_SIZE(field2),
> +			       GET_INTR_TARGET(field2),
> +			       cdnsp_trb_type_string(type),
> +			       field3 & TRB_IOC ? 'I' : 'i',
> +			       field3 & TRB_CHAIN ? 'C' : 'c',
> +			       field3 & TRB_ENT ? 'E' : 'e',
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
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
> +		ret = snprintf(str, size,
> +			       "type '%s' Buffer %08x%08x length %ld "
> +			       "TD size %ld intr %ld "
> +			       "flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
> +			       cdnsp_trb_type_string(type),
> +			       field1, field0, TRB_LEN(field2),
> +			       GET_TD_SIZE(field2),
> +			       GET_INTR_TARGET(field2),
> +			       field3 & TRB_BEI ? 'B' : 'b',
> +			       field3 & TRB_IDT ? 'T' : 't',
> +			       field3 & TRB_IOC ? 'I' : 'i',
> +			       field3 & TRB_CHAIN ? 'C' : 'c',
> +			       field3 & TRB_NO_SNOOP ? 'S' : 's',
> +			       field3 & TRB_ISP ? 'I' : 'i',
> +			       field3 & TRB_ENT ? 'E' : 'e',
> +			       field3 & TRB_CYCLE ? 'C' : 'c',
> +			       !(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
>  		break;
>  	case TRB_CMD_NOOP:
>  	case TRB_ENABLE_SLOT:
> -		ret += snprintf(str, size, "%s: flags %c",
> -				cdnsp_trb_type_string(type),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		ret = snprintf(str, size, "%s: flags %c",
> +			       cdnsp_trb_type_string(type),
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_DISABLE_SLOT:
> -		ret += snprintf(str, size, "%s: slot %ld flags %c",
> -				cdnsp_trb_type_string(type),
> -				TRB_TO_SLOT_ID(field3),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		ret = snprintf(str, size, "%s: slot %ld flags %c",
> +			       cdnsp_trb_type_string(type),
> +			       TRB_TO_SLOT_ID(field3),
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_ADDR_DEV:
> -		ret += snprintf(str, size,
> -				"%s: ctx %08x%08x slot %ld flags %c:%c",
> -				cdnsp_trb_type_string(type), field1, field0,
> -				TRB_TO_SLOT_ID(field3),
> -				field3 & TRB_BSR ? 'B' : 'b',
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		ret = snprintf(str, size,
> +			       "%s: ctx %08x%08x slot %ld flags %c:%c",
> +			       cdnsp_trb_type_string(type), field1, field0,
> +			       TRB_TO_SLOT_ID(field3),
> +			       field3 & TRB_BSR ? 'B' : 'b',
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_CONFIG_EP:
> -		ret += snprintf(str, size,
> -				"%s: ctx %08x%08x slot %ld flags %c:%c",
> -				cdnsp_trb_type_string(type), field1, field0,
> -				TRB_TO_SLOT_ID(field3),
> -				field3 & TRB_DC ? 'D' : 'd',
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		ret = snprintf(str, size,
> +			       "%s: ctx %08x%08x slot %ld flags %c:%c",
> +			       cdnsp_trb_type_string(type), field1, field0,
> +			       TRB_TO_SLOT_ID(field3),
> +			       field3 & TRB_DC ? 'D' : 'd',
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_EVAL_CONTEXT:
> -		ret += snprintf(str, size,
> -				"%s: ctx %08x%08x slot %ld flags %c",
> -				cdnsp_trb_type_string(type), field1, field0,
> -				TRB_TO_SLOT_ID(field3),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		ret = snprintf(str, size,
> +			       "%s: ctx %08x%08x slot %ld flags %c",
> +			       cdnsp_trb_type_string(type), field1, field0,
> +			       TRB_TO_SLOT_ID(field3),
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
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
> +		ret = snprintf(str, size,
> +			       "%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
> +			       cdnsp_trb_type_string(type),
> +			       ep_num, ep_id % 2 ? "out" : "in",
> +			       TRB_TO_EP_INDEX(field3), field1, field0,
> +			       TRB_TO_SLOT_ID(field3),
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
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
> +		ret = snprintf(str, size,
> +			       "%s: ep%d%s(%d) slot %ld sp %d flags %c",
> +			       cdnsp_trb_type_string(type),
> +			       ep_num, ep_id % 2 ? "out" : "in",
> +			       TRB_TO_EP_INDEX(field3),
> +			       TRB_TO_SLOT_ID(field3),
> +			       TRB_TO_SUSPEND_PORT(field3),
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
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
> +		ret = snprintf(str, size,
> +			       "%s: ep%d%s(%d) deq %08x%08x stream %ld slot %ld  flags %c",
> +			       cdnsp_trb_type_string(type),
> +			       ep_num, ep_id % 2 ? "out" : "in",
> +			       TRB_TO_EP_INDEX(field3), field1, field0,
> +			       TRB_TO_STREAM_ID(field2),
> +			       TRB_TO_SLOT_ID(field3),
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_RESET_DEV:
> -		ret += snprintf(str, size, "%s: slot %ld flags %c",
> -				cdnsp_trb_type_string(type),
> -				TRB_TO_SLOT_ID(field3),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +		ret = snprintf(str, size, "%s: slot %ld flags %c",
> +			       cdnsp_trb_type_string(type),
> +			       TRB_TO_SLOT_ID(field3),
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	case TRB_ENDPOINT_NRDY:
> -		temp  = TRB_TO_HOST_STREAM(field2);
> -
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
> +		temp = TRB_TO_HOST_STREAM(field2);
> +
> +		ret = snprintf(str, size,
> +			       "%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
> +			       cdnsp_trb_type_string(type),
> +			       ep_num, ep_id % 2 ? "out" : "in",
> +			       TRB_TO_EP_INDEX(field3), temp,
> +			       temp == STREAM_PRIME_ACK ? "(PRIME)" : "",
> +			       temp == STREAM_REJECTED ? "(REJECTED)" : "",
> +			       TRB_TO_DEV_STREAM(field0),
> +			       field3 & TRB_STAT ? 'S' : 's',
> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>  		break;
>  	default:
> -		ret += snprintf(str, size,
> -				"type '%s' -> raw %08x %08x %08x %08x",
> -				cdnsp_trb_type_string(type),
> -				field0, field1, field2, field3);
> +		ret = snprintf(str, size,
> +			       "type '%s' -> raw %08x %08x %08x %08x",
> +			       cdnsp_trb_type_string(type),
> +			       field0, field1, field2, field3);
>  	}
>  
> +	if (ret >= size)
> +		pr_info("CDNSP: buffer overflowed.\n");

"info"?

If the buffer overflows, was it properly truncated?  Or did we just
crash something else by passing on an overflowed buffer?

thanks,

greg k-h
