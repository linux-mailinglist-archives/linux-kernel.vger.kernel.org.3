Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C0C480A04
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhL1OeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:34:12 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:51404 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhL1OeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:34:11 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 9B78820991E5
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] xhci: re-initialize the HC during resume if HCE was set
To:     Puma Hsu <pumahsu@google.com>, <mathias.nyman@intel.com>,
        <gregkh@linuxfoundation.org>
CC:     <albertccwang@google.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211228060246.2958070-1-pumahsu@google.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <a8377a4a-9a90-5c99-88b8-4541ff5b1ad9@omp.ru>
Date:   Tue, 28 Dec 2021 17:34:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211228060246.2958070-1-pumahsu@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/28/21 9:02 AM, Puma Hsu wrote:

> When HCE(Host Controller Error) is set, it means an internal
> error condition has been detected. It needs to re-initialize
> the HC too.
> 
> Signed-off-by: Puma Hsu <pumahsu@google.com>
> ---
>  drivers/usb/host/xhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index dc357cabb265..c546d9533410 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1146,8 +1146,8 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
>  		temp = readl(&xhci->op_regs->status);
>  	}
>  
> -	/* If restore operation fails, re-initialize the HC during resume */
> -	if ((temp & STS_SRE) || hibernated) {
> +	/* If restore operation fails or HC error is detected, re-initialize the HC during resume */
> +	if ((temp & STS_SRE) || (temp & STS_HCE) || hibernated) {

	if ((temp & (STS_SRE | STS_HCE)) || hibernated) {

[...]

MBR, Sergey
