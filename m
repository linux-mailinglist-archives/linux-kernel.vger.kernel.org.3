Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A57489737
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244642AbiAJLUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:20:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244579AbiAJLTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641813571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FV5WIRsqm0pwBXS3k6O6n4ImctAVE3Kzf+EYc9TxZLA=;
        b=J2zdhr2DCHHpCBQpEouOuRx+hK35kr8KIproFMEkuI8NFEdraDf0v21Q6WZGg5BaqY+mLa
        Evq4zdPp+5reH7X/Eqb6qwz+CAOvm3VYiK33kZYk2qn/dZXHr+rtm8+ciyuR3Z6ytVI5RB
        Vu9WlrI4PWVf5rH9vEa4wIr6GthNUfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-6NiW1TebPkG2o6uBcI2SJA-1; Mon, 10 Jan 2022 06:19:28 -0500
X-MC-Unique: 6NiW1TebPkG2o6uBcI2SJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1A4B1015DA0;
        Mon, 10 Jan 2022 11:19:26 +0000 (UTC)
Received: from raketa (unknown [10.40.192.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B9AB7B6C5;
        Mon, 10 Jan 2022 11:19:24 +0000 (UTC)
Date:   Mon, 10 Jan 2022 12:19:21 +0100
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org, hch@lst.de, james.smart@broadcom.com,
        martin.petersen@oracle.com
Subject: Re: [PATCH -next] scsi: efct: don't use GFP_KERNEL under spin lock
Message-ID: <20220110111921.GA91632@raketa>
References: <20220110111838.965480-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110111838.965480-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.14.7 (f34d0909) (2020-08-29)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 07:18:38PM +0800, Yang Yingliang wrote:
> +	spin_lock_irqsave(&node->els_ios_lock, flags);
> +
>  	if (els) {
>  		/* initialize fields */
>  		els->els_retries_remaining = EFC_FC_ELS_DEFAULT_RETRIES;

If the els pointer is NULL you will lock the spinlock and disable the interrupts
for no reason, maybe you can just protect the list_add_tail()?

+spin_lock_irqsave(&node->els_ios_lock, flags);
 list_add_tail(&els->list_entry, &node->els_ios_list);
+spin_unlock_irqrestore(&node->els_ios_lock, flags);

Maurizio

