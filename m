Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAC353D34C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 23:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347186AbiFCVr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 17:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiFCVry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 17:47:54 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFFB19038;
        Fri,  3 Jun 2022 14:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=R8GTnEyemwPNA1+GV3RwGnFz7Pddor0BUU7Pj8Qp2lY=; b=URKgjPXDb1JIW7ndonnv7EZbQy
        Ecb089wAMy9eKRbsEjn6uUCU/uBkCkBwDHnbtTcp0DFsG99qKp8XZwSTIIFmSHuIE7QY1lLn9l971
        oCtf3+OMzFDpjzoVz0r21h1iVTstIy5wx2weK242c9qC0E53RhJb5wmTceciwlnGP+3DWCKR8ztOC
        Cf9jQNO5Oqod7Mze4nIFGXVWvVi3APdAV3C68AjOnPlgf7WYC2RAVMagvHbtQiIeM3u1MKTrFGtFx
        u0ePU8nipoNPRqCvwa/a3tn15m9Tkh8wJNDiMBVieFJwUFfaRTUrsS5tZGxD4mPDnknaUUn0DiCym
        MLD+fIGA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nxF93-00FOus-JV; Fri, 03 Jun 2022 15:47:50 -0600
Message-ID: <ff778bf2-9f99-db8b-90d4-d04e1c679e89@deltatee.com>
Date:   Fri, 3 Jun 2022 15:47:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-CA
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220602181818.50729-1-logang@deltatee.com>
 <20220602181818.50729-5-logang@deltatee.com> <YpmsuIQhk+i8LShF@infradead.org>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YpmsuIQhk+i8LShF@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@infradead.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, buczek@molgen.mpg.de, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v3 04/11] md/raid5-cache: Take mddev_lock in
 r5c_journal_mode_show()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-06-03 00:39, Christoph Hellwig wrote:
> On Thu, Jun 02, 2022 at 12:18:10PM -0600, Logan Gunthorpe wrote:
>>  	conf = mddev->private;
>>  	if (!conf || !conf->log) {
>> -		spin_unlock(&mddev->lock);
>> +		mddev_unlock(mddev);
>>  		return 0;
>>  	}
>>  
>> @@ -2557,7 +2560,7 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
>>  	default:
>>  		ret = 0;
>>  	}
>> -	spin_unlock(&mddev->lock);
>> +	mddev_unlock(mddev);
>>  	return ret;
> 
> Using a goto out_unlock would be nice here to keep the critical
> sections simple.  But even as-is this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
>> +	lockdep_assert_held(&conf->mddev->reconfig_mutex);
>> +
> 
> .. but this looks unrelated and misplaced in this patch.
> 

Ok, yup, I'll fix these issues up and send an updated series next week.

Logan
