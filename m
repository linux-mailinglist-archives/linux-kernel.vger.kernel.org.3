Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91776535649
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346029AbiEZXCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244679AbiEZXCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:02:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C16140F2;
        Thu, 26 May 2022 16:02:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y1so2902616pfr.6;
        Thu, 26 May 2022 16:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qfq77WBg1Op7K9Xp4Sx2ux31tzm9m+8JTsrYrGGZS+Y=;
        b=lS35t/WYo0rgjYg+4NtMjNyjSEkZ6IY36N5xvEeFDLxe9nhiZleC28hEb3/aQdqpfC
         KcGlOmS3eqZZ8vI8MqnmgAAGXGw9dUlegX4LqXaGOvNYTbG2TKykB76lxnIhL7Xqgnlm
         HfoQe7Qa7nkpu1UHbIvpLyUHVzWTWoonhMAL2BSbateS1CwWr2I+zJ7esg6SinsiOD1O
         z/Ckl0M68fopSnugpq1kOZgI5a/JpbNsoEdcL71sUVXzX6TtJuYF5QLJDfLf+GNX8Fw0
         MeD9AlyIUhLQ+POK4/mbUvOskALa3g8KJ2Sxi3A3BEccZln4o+DnQtPeUq26F5G//r71
         MMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qfq77WBg1Op7K9Xp4Sx2ux31tzm9m+8JTsrYrGGZS+Y=;
        b=mEqZWDlEz43lrCNVfkCXuy1BZA/7eA4wyozYEIa3cwNtlQaAHu35coFSEsuQFD/8Rn
         e00pNH/9DuCUadVITXjeOSWnQS+4NDGUjlQ7faGaw5TCTKxesvPXGCc7PI/HvxLWnRg0
         vQn8sFIJOqPWIcuKs1L+eAtoOtiWyWppXPDb06PZY996am9U6vhq3gox8BFTtt/QQW4G
         9q+SjbHNPUZ/GYEqN6lf8vtfgncphwQ4sE6X68RndNDuOz8AD75mOQpo8PiqMOle3m0b
         ONODrRn5Go9P6pNo7Sa1YSyslmGHdcNXWMPeu8Z1UqgicPM4COCoA7UGE9edhPGlPPYd
         4P1Q==
X-Gm-Message-State: AOAM533VnkYKPdJQIGJbm5K/q2rUx3ZGv2iq2OHCu2AsQ/tzDlncwQZp
        INtbtqLRUogGJHwSet+wm9gpnpDWuy4=
X-Google-Smtp-Source: ABdhPJzkSLIgSwaui9Fk8XA6PTS2/nWwAyfQRjNxVBiWrIloSSm4ww0YNZR8/59aznf2j8Eqd8LCcw==
X-Received: by 2002:a65:5c0c:0:b0:3fa:b2c0:7935 with SMTP id u12-20020a655c0c000000b003fab2c07935mr12778189pgr.600.1653606165137;
        Thu, 26 May 2022 16:02:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:ac0e])
        by smtp.gmail.com with ESMTPSA id d24-20020a170902729800b00161ea00350bsm2110096pll.277.2022.05.26.16.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 16:02:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 26 May 2022 13:02:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Message-ID: <YpAHEt0j30vBw9au@slm.duckdns.org>
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-5-frederic@kernel.org>
 <Yo/FGcG+uiBh88sT@slm.duckdns.org>
 <20220526225141.GA1214445@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526225141.GA1214445@lothringen>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 12:51:41AM +0200, Frederic Weisbecker wrote:
> > Does it even make sense to make this hierarchical? What's wrong with a
> > cpumask under sys/ or proc/?
> 
> I'm usually told that cpusets is the current place where CPU attributes are
> supposed to go. I personally don't mind much /sys either even though cpusets
> looks like a more flexible way to partition CPUs with properties and tasks
> placement altogether...

Yeah, I mean, if it's hierarchical, it's the right place but I have a hard
time seeing anything hierarchical with this one. Somebody just has to know
which cpus are up for rcu processing and which aren't. Waiman, what do you
think?

Thanks.

-- 
tejun
