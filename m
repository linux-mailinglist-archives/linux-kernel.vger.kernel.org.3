Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E1E46DB26
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhLHSgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:36:55 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:40837 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbhLHSgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:36:54 -0500
Received: by mail-pj1-f52.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so4958890pjb.5;
        Wed, 08 Dec 2021 10:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Ul403YxVr/GYiftUiCG88hiiZr2s1PeGaJxvBdtsT8=;
        b=waOTwsqIlHCwDEtIDB3KWcTvg/u19QLAOeY1PXovzEZzZqOQ7PY7Oe7T6v2Oyxo+HV
         VszBg6XtrVgBIVDBjnXEZhF/0lXSbc6nOIm8n0fwWoHCVhy6Th+PZW+0D1dVVNmFZA75
         Qoqfcnc0HrviC31T/1qUOVq6B1tNqWNj9Yr2SmaIocNWx2Fr+Ih7n+XQ2AbrjP11cGIn
         oW9ZSVcopp/2X4Vvkv/2E5kkphxhvuEio+6NwnqnKmajgyEypg4fUORFAky2XlZHNCnr
         6wJfKMrEUbTW0BoSq4EM71aEvjzOWad0p+aFGwZMiBEYKfNlO3XCIQ1PiaRgtlX5Jq9w
         B4ig==
X-Gm-Message-State: AOAM533di1mprs6xpQPSaQbTDhDRNp9zFYPcEBx47L5iB4fRSmnXDn2a
        RTj/hjCPxUOeTBJu2qjWgZE=
X-Google-Smtp-Source: ABdhPJwtZaHD65Ey7j2mBc/tceKRoVjtndShk4+nAhyRh6rjPUEY9qXnLiu0tO8JWWe/JkawlVxYpA==
X-Received: by 2002:a17:90b:3b82:: with SMTP id pc2mr9383862pjb.120.1638988401779;
        Wed, 08 Dec 2021 10:33:21 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:18af:8865:db7e:6769])
        by smtp.gmail.com with ESMTPSA id n15sm3248400pgs.59.2021.12.08.10.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 10:33:20 -0800 (PST)
Subject: Re: [PATCH v2 6/8] docs: sysfs-block: document virt_boundary_mask
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20211208005640.102814-1-ebiggers@kernel.org>
 <20211208005640.102814-7-ebiggers@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <13462e59-82f3-d6fc-a84e-2cf3083e0cc7@acm.org>
Date:   Wed, 8 Dec 2021 10:33:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208005640.102814-7-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 4:56 PM, Eric Biggers wrote:
> +What:		/sys/block/<disk>/queue/virt_boundary_mask
> +Date:		April 2021
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RO] This file shows the I/O segment alignment mask for the
> +		block device.  I/O requests to this device will be split between
> +		segments wherever either the end of the previous segment or the
> +		beginning of the current segment is not aligned to
> +		virt_boundary_mask + 1 bytes.

"I/O segment alignment" looks confusing to me. My understanding is that this
attribute refers to the alignment of the internal data buffer boundaries and not
to the alignment of the offset on the storage medium. The name "virt_boundary"
refers to the property that if all internal boundaries are a multiple of
(virt_boundary_mask + 1) then an MMU with page size (virt_boundary_mask + 1) can
map the entire data buffer onto a contiguous range of virtual addresses. E.g.
RDMA adapters have an MMU that can do this. Several drivers that set this
attribute support a storage controller that does not have an internal MMU. As an
example, the NVMe core sets this mask since the NVMe specification requires that
only the first element in a PRP list has a non-zero offset. From the NVMe
specification: "PRP entries contained within a PRP List shall have a memory page
offset of 0h. If a second PRP entry is present within a command, it shall have a
memory page offset of 0h. In both cases, the entries are memory".

Bart.
