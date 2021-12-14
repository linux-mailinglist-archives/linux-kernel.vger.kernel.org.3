Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2EC473C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhLNFEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:04:35 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:47023 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhLNFEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:04:33 -0500
Received: by mail-pl1-f176.google.com with SMTP id p18so12712660plf.13;
        Mon, 13 Dec 2021 21:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c2eV4osFi0ukdYwPMjLg4N3OH2klHkHbVnzvE6IHZ0A=;
        b=wEqEV+/9CiNSZYZGSClvtFvEZalNUojZKZ8P8ayPuH+rE0zK0mAOAOx+wejIDryIYW
         Xwqb/jaaxisYe8FhrUD9u6hbsjm01W9NTjt/KrU1DfC0LG0/yoA/8ZQgDrrpBJseIWS2
         mWkR6q+5D0MtR5namKw9PrjYWDSVp5NsRa7Nk2ngu9cpjmtGdkUOr/m0oIPSWW/Ff1s8
         gQNUkoBHRuX0moXura+ciwLptS7U/O4/bhbW4IFaQnVNqLbFzs4O3d61yjLtYtwSiMfo
         j0ryFnaYBPXDmRHxHtmkObbFYvsqCtFfxsC8bqanTuYS+2NbOUUTcgNkH0yOlmbvZHYv
         NV/Q==
X-Gm-Message-State: AOAM533XgXoDd+09MvA8mPVBxyFp3+wRmP1GD87w4XHYPiZIPDKd0Mqd
        Aqm2thvZjDhTq16EYH1AdpI=
X-Google-Smtp-Source: ABdhPJwtMlRpUdDYK54zZy9LApP/DL9N5L+IrnomqaNOXiFC+OMI9PifWtvDjkZweUk0AUMLjAtr2A==
X-Received: by 2002:a17:902:9f98:b0:144:e777:f88e with SMTP id g24-20020a1709029f9800b00144e777f88emr3021815plq.31.1639458272383;
        Mon, 13 Dec 2021 21:04:32 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id me3sm688683pjb.35.2021.12.13.21.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 21:04:31 -0800 (PST)
Message-ID: <a4b285ba-4a46-c94b-444e-d3c4f42c42c5@acm.org>
Date:   Mon, 13 Dec 2021 21:04:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/3] blk-crypto: show crypto capabilities in sysfs
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-4-ebiggers@kernel.org>
 <6ff4d074-7508-4f4c-de06-f36899668168@acm.org>
 <YbKT/lcp6iZ+lD4n@sol.localdomain> <YbL2uUqV0GWFOitE@kroah.com>
 <cb29756b-8b21-5b4d-f107-b5573945d7ab@acm.org> <YbSCYyAv1SmYy7mz@kroah.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YbSCYyAv1SmYy7mz@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/21 02:50, Greg Kroah-Hartman wrote:
> On Fri, Dec 10, 2021 at 09:29:41AM -0800, Bart Van Assche wrote:
>> (b) No other block layer sysfs attribute follows this encoding scheme.
> 
> Then follow what they do.  Do they have multiple values in a single
> file?  If so, they are broken and we should change that.

Hi Greg,

The only other block layer sysfs attribute I know of that reports 
multiple values is the queue/scheduler attribute. Here is an example of 
the output that can be produced by reading that attribute:

# cat /sys/block/sda/queue/scheduler
[mq-deadline] kyber bfq none

I don't think that changing the behavior of that attribute is an option 
because that would break existing user space software, e.g. the 
https://github.com/osandov/blktests/ test suite.

Thanks,

Bart.
