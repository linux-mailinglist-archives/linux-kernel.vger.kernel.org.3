Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF98A461BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346054AbhK2Qja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:39:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34872 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344160AbhK2Qh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:37:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E8D9B80E62
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F81C53FAD;
        Mon, 29 Nov 2021 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638203649;
        bh=kS3HRdvH9zUxYELkE5d5GqTNaRMV/o7y2I7+v9B3DAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zg57YRVTTRQ+ZZHSiWe1mkUFx0ZoD4yc9oaDrfknYaSI5xCRIY/HvbTZyhVSJv1xz
         Me/HEUjYxSDhVzN/TjP1fP18SXjDPcBTQwFZaKYGHq6KK6iQj+WDqxFzMt+bHOAlEY
         TSMd3HMFpO2UErEsZG6lQfkccGBXpJmbSo5FhgQHGp7hAHdTU/oN3dw6mvZUvn5Nue
         lkAvhaK+RIVH0e0fNy5lBTm/6tH1jvv0a3BUxpUfG2uj+woC4gsqpQcTroX1OutK3i
         9KYbJHt1buRvVZm75AouKS9j5nYmHLVLGerKs89nafqHx84B5IMX4LVtMs2hK44iHF
         2AMpBOwTJwYKA==
Date:   Mon, 29 Nov 2021 08:34:06 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: duplicate NQNs check if devices needed
Message-ID: <20211129163406.GA3582042@dhcp-10-100-145-180.wdc.com>
References: <20211129111854.44006-1-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129111854.44006-1-zhangliguang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 07:18:54PM +0800, Liguang Zhang wrote:
> @@ -2587,6 +2587,9 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
>  
>  	lockdep_assert_held(&nvme_subsystems_lock);
>  
> +	if (strncmp(subsysnqn, "nqn.", 4))
> +		return NULL;

This seems like an arbitrary way to decide not to check for duplicates.
Shouldn't we just add the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk for the
broken controllers?
