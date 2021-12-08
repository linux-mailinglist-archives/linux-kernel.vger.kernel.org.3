Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3046DEC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbhLHXCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 18:02:40 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:41592 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240729AbhLHXCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 18:02:39 -0500
Received: by mail-pj1-f43.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso3385929pjb.0;
        Wed, 08 Dec 2021 14:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upn5pCTEbLoqxAzE9pPLnLbRKo8NrWejD9fWmOQQq6A=;
        b=7zMqCwD7Ixt/qAdGJHw6eGNfXKeZf+LiYnjD4bS2xXr+aFtPikIbFY5zUOlRQUcJte
         Bl1xp4K9LOXtcVsM5+SM87h9SqoNI1sCVENx4WWbsy4ekkpZjDYNPJSOkEyuJr20C4X7
         X38wTnhYBidQP5rzWbJY4WLZTeDumq+o1hSNI5cRFzTN28RDrm7pMecEm+/dgBkpUK2L
         4MdB+6z1poLfhUX2+ytvZ5tgXnPkU9ggVXfYKJvVs+TcwUF0xHmi8CncMTOFJc01BMfe
         Cw0DHAJpfW98kTrlxtFVD9LB73XXUfakOl97FPlEo4gHRtJ9L9q6xallRJPnoBFEIPYM
         31/g==
X-Gm-Message-State: AOAM532i3UokRhJ6SsXw/ROgzlfnnhGPsHrG0s9gcV/l/tKw1eSHp/cK
        Kjijx2nXQjE/RKpJMfeXGYs=
X-Google-Smtp-Source: ABdhPJzC6On7oHVJPBngf8TPLy2ERLA7zL/IiPmRnpomSCFak06QwtXDRgh7S5Y0l35e++5qLMRWfw==
X-Received: by 2002:a17:902:c643:b0:141:cf6b:6999 with SMTP id s3-20020a170902c64300b00141cf6b6999mr63193988pls.80.1639004346367;
        Wed, 08 Dec 2021 14:59:06 -0800 (PST)
Received: from ?IPv6:2620:0:1000:2514:2f89:deb4:72f3:8a11? ([2620:0:1000:2514:2f89:deb4:72f3:8a11])
        by smtp.gmail.com with ESMTPSA id mz7sm7261715pjb.7.2021.12.08.14.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 14:59:05 -0800 (PST)
Subject: Re: [PATCH v2 5/8] docs: sysfs-block: document stable_writes
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20211208005640.102814-1-ebiggers@kernel.org>
 <20211208005640.102814-6-ebiggers@kernel.org>
 <7d9f9469-5347-780a-c560-77fca6e7008b@acm.org> <YbEy9tKDwf5Jthl1@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b8422f2f-b9cb-7914-b94a-559de8315371@acm.org>
Date:   Wed, 8 Dec 2021 14:59:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbEy9tKDwf5Jthl1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 2:34 PM, Eric Biggers wrote:
> Yes, I meant "written out to disk" in the general sense of writeback, not in the
> sense of when the data reaches its final destination.  I'm not sure what the
> best way to explain it is.  I think it's more than just "the process of
> transferring data from host memory to the device", as that is just part of a
> write request, whereas stable_writes applies to whole requests.  How about:
> 
> 		[RW] This file will contain '1' if memory must not be modified
> 		while it is being used in a write request to this device.  When
> 		this is the case and the kernel is performing writeback of a
> 		page, the kernel will wait for writeback to complete before
> 		allowing the page to be modified again, rather than allowing
> 		immediate modification as is normally the case.  This
> 		restriction arises when the device accesses the memory multiple
> 		times where the same data must be seen every time -- for
> 		example, once to calculate a checksum and once to actually write
> 		the data.  If no such restriction exists, this file will contain
> 		'0'.  This file is writable for testing purposes.

The above sounds good to me.

Thanks,

Bart.
