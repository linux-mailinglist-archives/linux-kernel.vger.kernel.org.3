Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0B14F1363
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358600AbiDDKzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358537AbiDDKz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD826205
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649069607;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nmzUc45Prh1+ExDpLCMwSGqWxkU2qU0qcCSpLdKeeqE=;
        b=HHODCq6R6rVhfA9/7DYTxix82oJS4zX/GXO73D/jNWfzFOBDUghSiAnpEklbgy5fuAib/v
        C2ysV2cl1U7AqCqXjEBjp68zxvas5TwS+75meyH6OzeR+j81l60VN+yshGKBbj/1D2tMxZ
        Kh10E/pdqVdkLyahVl1HJYfBK8gEEMQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-TgDyIROjNeS1TDN_4ihA_Q-1; Mon, 04 Apr 2022 06:53:24 -0400
X-MC-Unique: TgDyIROjNeS1TDN_4ihA_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B7EA3C01B86;
        Mon,  4 Apr 2022 10:53:23 +0000 (UTC)
Received: from [10.72.12.126] (ovpn-12-126.pek2.redhat.com [10.72.12.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B62AC584FA;
        Mon,  4 Apr 2022 10:53:15 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 00/18] Support SDEI Virtualization
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shannon Zhao <shannon.zhaosl@gmail.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <a3bf5b44-0ab8-fd85-5557-6c496fd68bc1@redhat.com>
 <YkqLtYquZQAKjbAk@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <6f9b7597-f559-8218-a3ea-12da37c4c10f@redhat.com>
Date:   Mon, 4 Apr 2022 18:53:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YkqLtYquZQAKjbAk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 4/4/22 2:09 PM, Oliver Upton wrote:
> On Sun, Apr 03, 2022 at 11:47:07PM +0800, Gavin Shan wrote:
>> I'm explicitly copying Oliver, James, Mark and Shannon to avoid resending this series.
>> It seems they have been skipped even I explicitly copied them by 'git send-email --cc=<email-addr>'.
> 
> Dunno about others, but FWIW your first crack at sending this series out
> arrived in my inbox just fine :)
> 
> Thanks for cc'ing me, I'll find some time this week to take a look.
> 

Thanks for letting me know the emails and patches have been delivered
correctly. Please take your time to review and thanks for your comments
again :)

Thanks,
Gavin


