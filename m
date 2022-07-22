Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C046657E692
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiGVSdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbiGVSdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 943DF9FE02
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658514827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cuAxCjPb5JwgxHvfPH5uVtncIHsSNNJ86IoETDkzjWI=;
        b=VkQ3V3glT11ihfQbjIHCHlr0yn6Udp4bQi8C+Qw5E2pcRkaXv7z7Yj9e6mdD3UPdwCuKgg
        p8gra1UZTjo0GRvie1NmMwsAxw4FjP56JKvSZ3bJTvsiCgqrve/fPz1SCuMQ/usEzU9zSy
        xZHma3JFnbRuQoj278Mwc7r6hn44HzA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-OSNAjzr8PCyOtlcVASd4UA-1; Fri, 22 Jul 2022 14:33:46 -0400
X-MC-Unique: OSNAjzr8PCyOtlcVASd4UA-1
Received: by mail-qk1-f199.google.com with SMTP id o13-20020a05620a2a0d00b006b46c5414b0so4345983qkp.23
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cuAxCjPb5JwgxHvfPH5uVtncIHsSNNJ86IoETDkzjWI=;
        b=GE6fnYnQVTX2Tyo/XxDrbuq/tIdFKEDY58uumXFsxAoYabaBEdCJyiJga5el3/Fl7f
         kIyDH/tf85uJjcKjU1aIC1KZvSwxUqozu1wmHGNrnLDxhoRwhqjdTVoFTPay2TkUBoUx
         gDc3Z1o48wPBqGP9JHET3hgdrrDMarFvOUL80/Pd3qIyIBw62vZPxV0cVfomTPAm2u2R
         LvByGFCJjNK+0v2BOSqZCn8cWglz9LHPOSysTyouYD6qdwfBZ2s8BYJeZU7d2qDDDDAi
         lv1S/6DW3tpnUwINFWKf66ctxI60rZ5MVPb9yF1bv1xzpcIXfNFCYuHoZglBA4uaQpy0
         O6EA==
X-Gm-Message-State: AJIora8AEx41mprVebUqb5UTkSvqismSR+zw9hkvn9wvBmaj6YtNkusd
        FtmkCqLGvJzsH7ml04msLqzrMidbNUSenFsBxIuuHNXkgyUNL2QTauZhTkD2tfUYq71IjoV30hK
        wUe4oE76lf8MAj9XOTTeyFNQ=
X-Received: by 2002:a05:6214:d66:b0:473:7906:ac4f with SMTP id 6-20020a0562140d6600b004737906ac4fmr1312619qvs.126.1658514825963;
        Fri, 22 Jul 2022 11:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uwdMklIfR1RPb6muiHD6u2FhgP1jhA5kPEp8IEKapJ297TmS1h5GutOZjOQ2Ki8tYs42IJtg==
X-Received: by 2002:a05:6214:d66:b0:473:7906:ac4f with SMTP id 6-20020a0562140d6600b004737906ac4fmr1312606qvs.126.1658514825674;
        Fri, 22 Jul 2022 11:33:45 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a0f1100b006b55036fd3fsm3882891qkl.70.2022.07.22.11.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:33:45 -0700 (PDT)
Date:   Fri, 22 Jul 2022 14:33:44 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Snitzer <snitzer@kernel.org>,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        dm-devel@redhat.com, Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 0/3] dm-verity: optionally use tasklets in dm-verity
Message-ID: <YtrtiP2p8xnRdC3S@redhat.com>
References: <20220722093823.4158756-1-nhuck@google.com>
 <YtrTI/CJMoLihA/1@infradead.org>
 <cabd732a-9942-3ece-8141-c0bc6378faca@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cabd732a-9942-3ece-8141-c0bc6378faca@acm.org>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22 2022 at  2:12P -0400,
Bart Van Assche <bvanassche@acm.org> wrote:

> On 7/22/22 09:41, Christoph Hellwig wrote:
> > We've been tying to kill off task lets for about 15 years.  I don't
> > think adding new users will make you a whole lot of friends..
> 
> +1 for not using tasklets. At least in Android the real-time thread
> scheduling latency is important. Tasklets are not visible to the scheduler
> and hence cause latency spikes for real-time threads. These latency spikes
> can be observed by users, e.g. if the real-time thread is involved in audio
> playback.

OK, then android wouldn't set the _optional_ "try_verify_in_tasklet"

Mike

