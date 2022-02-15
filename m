Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831434B6603
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiBOI2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:28:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiBOI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:28:18 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 00:28:07 PST
Received: from smtpcmd04132.aruba.it (smtpcmd04132.aruba.it [62.149.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7107BC4879
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:28:07 -0800 (PST)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id JtAqnmJBWkz4hJtArn8LoA; Tue, 15 Feb 2022 09:27:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1644913625; bh=8nPRq6Z1HB7fPFqYMwhe15lCOX2QtBx9b2dpoJr1ogo=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=Q09LT1U3DY336is7+YUIKcVO/I/60zP5iltGeQ4t7UM6qeqBl5jMm3lpItDrhBwD3
         7Lh1irNNh75UTIjxfRdZcu1IUAQOFB2d2CGPRVZdgYLxyxOLIB9uvQ5H/PbRJGvqBI
         QgKmVX6nNMhWXDrSsJi0bKh1NyFUhlDPXRG4sWgjy9E4lg0QAt6QhfYTB5z/MBCATC
         mfpRSgoIGC5oA/mHGsBvrzfBkmDo/B9fqMrUIA3hHIW5l5RLXze5c1VKzJ4wMo0dW1
         yHScCzlMS67SELp4VeECc4KQuJaUB1EY1y58KkJrF6tSgQLTk83K4MjUCY43wyKmUE
         jsKRwYlcGEB/Q==
Message-ID: <b48e9155-2937-dd1f-2a54-61651f3c4190@enneenne.com>
Date:   Tue, 15 Feb 2022 09:26:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Replacing ktime_get because elapsedRealtime includes time
 spent in sleep and pps should be also including sleep time.
Content-Language: en-US
To:     Alexander Komrakov <alexander.komrakov@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20220117073835.1430628-1-alexander.komrakov@broadcom.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20220117073835.1430628-1-alexander.komrakov@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDEVjpqmlHFQpkmBvkpKYqtr2h4l5lMKp+TYriaj6pe/QOk8RTkwz60igRB7/EsnUjf2sMZJL4N2J8JdAY3aCwVhOpz3PgXNE7M9A+VnkXMQ7+1RVjU+
 RmL9bIei1UXGt9vpsHKYBDjA9oSDmDulWQ6jSTyca5s5COyjshVnGOg+Er8vMG637wxy7o+KGnAEFy/u2M7Gk5sOlCn86VsHPpc5pD77OQ/2WB/9Im7Lti5c
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/22 08:38, Alexander Komrakov wrote:
> From: alexander komrakov <alexander.komrakov@broadcom.com>

Very long subject and missed description.

Let me suggest to replace the subject as "pps kapi: use 
ktime_get_boottime_ts64() to include time spent in sleep".

And add a description as:

Since ktime_get() stops during suspend, we replace it with 
ktime_get_boottime_ts64() because elapsed realtime includes time spent in sleep 
and pps should be also including sleep time.

Ciao,

Rodolfo

> Signed-off-by: alexander komrakov <alexander.komrakov@broadcom.com>
> ---
>   drivers/pps/kapi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
> index 149c29e498fc..6d1fbe4a8c40 100644
> --- a/drivers/pps/kapi.c
> +++ b/drivers/pps/kapi.c
> @@ -38,7 +38,7 @@ static __u64 clock_gettime(struct pps_ktime *kt)
>   {
>   	struct timespec64 ts = { .tv_sec = 0, .tv_nsec = 0 };
>   
> -	ktime_get_ts64(&ts);
> +	ktime_get_boottime_ts64(&ts);
>   	kt->sec = ts.tv_sec;
>   	kt->nsec = ts.tv_nsec;
>   	return (__u64) ts.tv_sec * NANOSEC_PER_SEC + ts.tv_nsec;

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
