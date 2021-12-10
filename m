Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5472546F7D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 01:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhLJAFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 19:05:45 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:35541 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhLJAFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:05:44 -0500
Received: by mail-pg1-f181.google.com with SMTP id j11so6562402pgs.2;
        Thu, 09 Dec 2021 16:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yA/aqRRdxwwCKYya8U7fCRHLT+HqlVgM1BDHiY8sGVo=;
        b=VqnFPvZSyUUrKsdb3CQOKmd3M+0hVGSJxQHTjByJMzzxSbpaNZxyZ6dmm3gWFJVWqv
         QrjLJk9JPM2Voyo12GanoU8n3oAg480rGMR6Ll6gUPxyW4bAV2s1GORmJ2y2kXw0sktr
         4RLjp4wzXhVyQRWfRbhElskpLxxLFOZdKQkbDyIHQooKn1pNQuOC3f4hxWPQ6Az0X8x0
         7zbzSlJZWzPLu1s/mR9Vt1PrlYyeBw3GnXB1Neltbav104pBXX2XSwenxubyDphg7BcG
         XYttF2umWKAJbeeFdaROeX/ugwcrFAM5XatZMkS6J6pqImLjBO+qzCVQG3+b69D0x76e
         BXAw==
X-Gm-Message-State: AOAM531juLuhD1HYFQO24mV4VDQyWnC5YBps8d3VCYhR4LtPD4HxinGz
        hCfqoGc5XZxKYUsWr9yFhlw=
X-Google-Smtp-Source: ABdhPJxRCpNcaP7au1Et7qITghCRdjcXOI8Qfk37HZXiEnUoTj5cxY+KfH/kKnQJID77Y3VJMyVzzQ==
X-Received: by 2002:a63:1158:: with SMTP id 24mr36047053pgr.193.1639094530174;
        Thu, 09 Dec 2021 16:02:10 -0800 (PST)
Received: from ?IPv6:2620:0:1000:2514:4f5b:f494:7264:b4d4? ([2620:0:1000:2514:4f5b:f494:7264:b4d4])
        by smtp.gmail.com with ESMTPSA id mh1sm743567pjb.6.2021.12.09.16.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 16:02:09 -0800 (PST)
Subject: Re: [PATCH v3 3/3] blk-crypto: show crypto capabilities in sysfs
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-4-ebiggers@kernel.org>
 <6ff4d074-7508-4f4c-de06-f36899668168@acm.org>
 <YbKT/lcp6iZ+lD4n@sol.localdomain>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <de725f08-2f98-56fc-8305-baf93f867af3@acm.org>
Date:   Thu, 9 Dec 2021 16:02:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbKT/lcp6iZ+lD4n@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 3:40 PM, Eric Biggers wrote:
> On Thu, Dec 09, 2021 at 02:51:59PM -0800, Bart Van Assche wrote:
>> Has it been considered to report each value separately, e.g. 512\n4096\n
>> instead of 0x1200\n?  I think the former approach is more friendly for shell
>> scripts.
> 
> I don't think that would be acceptable to the sysfs folks, as they only allow
> one value per file.  I suppose a bitmask could be viewed as unacceptable too,
> but it seemed to make sense here, given that the data unit sizes are always
> powers of 2, and the hardware reports them as bitmasks.

In case Greg wouldn't have the time to reply, I think the following quote from
Documentation/filesystems/sysfs.txt is relevant in this context: "Attributes
should be ASCII text files, preferably with only one value per file. It is
noted that it may not be efficient to contain only one value per file, so it is
socially acceptable to express an array of values of the same type."

Thanks,

Bart.
