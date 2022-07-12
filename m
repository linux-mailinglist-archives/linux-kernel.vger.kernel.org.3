Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4C571CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiGLOiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiGLOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:37:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0062707
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:37:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso8206676pjj.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=fo//0I0AslshoYVyaZDmo1hPdJN5skuX2wqL7b4ff0Q=;
        b=jUUaGMYMJc1jvzr5WBavgHoBCc460nCY1fRSyTSANegMRdHDSgqIiysHoCTftA8yCI
         rX2mPjpliOL9g0CuwJOCMUvsvbxXbT/efus1kWmgnQ3vuZ4CoYpmKOogIhM9OrLDfG/G
         V3wlWA+HzNK/eUNN2t7eSXCNz+xBkcVncT2ArpHJay7n1NXiplYWVaDL2i201+r+apom
         c+SMcD1h4CTY5HOLZ89flF44MCFoufvlNcHc9PJUWsuoej1d8swkYm0D3fU7h4H/2sCR
         zSGqJjlcE432FeQ9PoZs/EaOEpRUooSTTmLCze0/yS3hcE4NJgaA8kq+obyEtnctnHaD
         iEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=fo//0I0AslshoYVyaZDmo1hPdJN5skuX2wqL7b4ff0Q=;
        b=m3s/o4UKrItTno+grBs5x554hoVRvbTw9nNT1d6ckWOVOLhQCn1CQcfDPx1YaIY5U/
         wUR0qTIrpETpr4vf5i1nicmvpkLPYpBxW+WOB2cQ74tCuzSZpRcwxLLZMbe3EI+80i4l
         RcTZEcMLle6IFnQowabKJ1LVan2VIpw6ENZxRrJR9E2VmtgVjouqMJBeU6dBYZq3JQCR
         KFTj4WLAsTSXBcrEf9Rg0f+zIgGBxEYYi8Gfzf3XHZ6e7SR04saN5dlQs7IwJ4XQh2B+
         VzzHZHm+s3d2XKu1Me7McxnC5ANScJtY8uX781mrdo3YlnGwkqw0hHdjr3l23Af7XMT4
         T3yg==
X-Gm-Message-State: AJIora+34Qly8WLF0UcN+eGG/Blc+TTsf5J2GLX+YkjikuWaPqxgWuLo
        YHg6JKMlksn+5EGw1Q9qDxABnSS4mhrBWw==
X-Google-Smtp-Source: AGRyM1uH9tzK5trUw3ts3HkjrhqLJ1vmb3prkMen4qeAaIfcwjw2kRqOsAtvAZGkdoZURV7zBp/qpA==
X-Received: by 2002:a17:902:ff0f:b0:16b:db22:717c with SMTP id f15-20020a170902ff0f00b0016bdb22717cmr24466722plj.94.1657636676892;
        Tue, 12 Jul 2022 07:37:56 -0700 (PDT)
Received: from ArchLinux (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id a12-20020a62d40c000000b00528d8ce7394sm6822670pfh.125.2022.07.12.07.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:37:56 -0700 (PDT)
References: <20220712013125.623338-1-schspa@gmail.com>
 <20220712095325.408d1730@gandalf.local.home>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] sched/rt: fix bad task migration for rt tasks
Date:   Tue, 12 Jul 2022 22:37:05 +0800
In-reply-to: <20220712095325.408d1730@gandalf.local.home>
Message-ID: <m28royflc9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 12 Jul 2022 09:31:24 +0800
> Schspa Shi <schspa@gmail.com> wrote:
>
>> @@ -1998,11 +1998,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>>  			 * the mean time, task could have
>>  			 * migrated already or had its affinity changed.
>>  			 * Also make sure that it wasn't scheduled on its rq.
>> +			 * It is possible the task was scheduled, set
>> +			 * "migrate_disabled" and then got preempted, And we
>> +			 * check task migration disable flag here too.
>
> Nit.  "got preempted, so we must check the task migration disable flag here
> too".
>

OK, I will make a upload for this too.

> But other than that.
>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> -- Steve
>
>>  			 */


-- 
BRs
Schspa Shi
