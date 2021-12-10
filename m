Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93546FDB4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbhLJJ33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:29:29 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58812 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbhLJJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:29:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 558371F3A0;
        Fri, 10 Dec 2021 09:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639128351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wf9vb8M1IAE2GO6dm0K8PPb5mu0IWeheJoH7UpjmkIQ=;
        b=mRgJijdA90Egw5DrcHGPs/G84NyI6TAIuLnJ/O/S8cIbluRf9ypFGStFZ5hdtcpdW0NCBt
        5Fvcuzx+VB9BnGbRGbUavkn0GdMsyF8jW3d5v2Gvgnm/ZpZiTEnuWDwCC4ND18qSK0gOyG
        aQz0/XjfXDF34wCrZUPfo4r1X8vvruY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639128351;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wf9vb8M1IAE2GO6dm0K8PPb5mu0IWeheJoH7UpjmkIQ=;
        b=Oa3KC4txqB3VHKby2Ljjj5KfVc9WjvUZUEfV4LfX661FLB96451iTBlEQSuTH2G1h29siH
        rErxAqCGxtmYdyDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4836513E15;
        Fri, 10 Dec 2021 09:25:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f55bER8ds2EkMgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 10 Dec 2021 09:25:51 +0000
Subject: Re: [PATCH v1 2/3] ata: sata_dwc_460ex: Use temporary variable for
 struct device
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211209143519.60498-1-andriy.shevchenko@linux.intel.com>
 <20211209143519.60498-2-andriy.shevchenko@linux.intel.com>
 <5d98df66-a1fb-a2cf-f780-963bf26f6d1e@opensource.wdc.com>
 <CAHp75Vezco85W+TG+ehtMwtUyFubb+fbnn5XuyNQiNX4mJczXg@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <be7f4ab7-3625-8b84-9d58-fd2958daa031@suse.de>
Date:   Fri, 10 Dec 2021 10:25:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vezco85W+TG+ehtMwtUyFubb+fbnn5XuyNQiNX4mJczXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 9:42 AM, Andy Shevchenko wrote:
> On Fri, Dec 10, 2021 at 4:25 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 2021/12/09 23:35, Andy Shevchenko wrote:
>>> Use temporary variable for struct device to make code neater.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> What is this based on ? Is this on top of Hannes series ?
> 
> Nope, on latest (available) Linux Next.
> Hannes, can you incorporate this to yours maybe? I see one conflict
> with the last patch.
> 
Sure.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
