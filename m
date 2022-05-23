Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD6530722
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 03:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349093AbiEWBZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 21:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349555AbiEWBYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 21:24:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13389387BB
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 18:24:49 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id x12so12380947pgj.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 18:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=L4SbZUHV57IOdhtxt7xLH6bNMt6ZWWMzVkJzxIHiEH0=;
        b=mKhLX5Tl0/hJE/WYln3le1t/gPQuRKOiDHXpUCFFlMUfiqaQJhiCx5ESuSoqzPiwxY
         FXa/cYM1iJaf72An99no6KGCCFyWV/Y2vRmv9AyIf1bZRVEt0Io5RGmKrwslo9UMVfbn
         V3ZRIolNVAS+vrRVoHgUVKsfwMQfVoH8KJlOmRHHVgYUnelmfQuTSvoSoYfQgPYexLSb
         47m/RqFJLuZB/TU+1yL9seNjlqVFWx72k1DMQFHQm/IGAOMlqlsM6TwMN6E4Wcxdc2LN
         MZVGrcLrcF06ZuDyy5Ed6nFp/U+N3coelcUamn32psMV6ZgaQg6mqhYx6vEjvMjCWMeE
         E8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=L4SbZUHV57IOdhtxt7xLH6bNMt6ZWWMzVkJzxIHiEH0=;
        b=HSi+X+hq5VHBUP6Y36zjzSHxntPQgHTBpHLzU8t/74I0PWpsm+sZkshTd05qw291iw
         FocJizdGmxl5zi/HnHtqGJivmCWAZhQ+8YChf3fWAR1tKtWYBobLNJf+r86ZqBdNWss6
         yCePLDybLAUA9Ynkxwzj0ej5kqldCLCL3kMJ+iKYqlr1llecyong9aD/JKvZXp6bTQqn
         uiw6e0WR/cgCX1eb8kL+XQSFTG9WqRiHf1aVwmR54wz1OmTqwYtxLtyb4JW9+ZU6w7Gz
         XRFrsxKW5QYwzfZn8TwX/Y82Q0wH1ttAUyJNhq0Cj0jSxFrvLi0TWUUYnrGkSV9J96k2
         vzlw==
X-Gm-Message-State: AOAM533lkliOOLtRfyAySgU1d/hzRy4bVEDds8ZEbZzfqConK3VcHbRP
        AOM0rAgDjAD8F2OADMEmTLmWiw==
X-Google-Smtp-Source: ABdhPJx0C/kAHO9Og4a8sFT18y/We0Q5yc2XHHJxoU1ByVr+bvY/kxzcZ7clBGdH5p/Z1lU+2tLtsg==
X-Received: by 2002:a05:6a00:24c6:b0:518:7e6e:ee3c with SMTP id d6-20020a056a0024c600b005187e6eee3cmr10143984pfv.15.1653269088360;
        Sun, 22 May 2022 18:24:48 -0700 (PDT)
Received: from [2620:15c:29:204:fa22:6f61:557f:9cd2] ([2620:15c:29:204:fa22:6f61:557f:9cd2])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a1b0600b001df7612950dsm5900242pjq.7.2022.05.22.18.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 18:24:47 -0700 (PDT)
Date:   Sun, 22 May 2022 18:24:47 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     John Allen <john.allen@amd.com>
cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        seanjc@google.com, Thomas.Lendacky@amd.com, Ashish.Kalra@amd.com,
        linux-kernel@vger.kernel.org, theflow@google.com,
        pgonda@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] crypto: ccp - Use kzalloc for sev ioctl interfaces
 to prevent kernel memory leak
In-Reply-To: <20220518153126.265074-1-john.allen@amd.com>
Message-ID: <81d016a4-891c-47e6-8a85-7cd9e5661729@google.com>
References: <20220518153126.265074-1-john.allen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022, John Allen wrote:

> For some sev ioctl interfaces, input may be passed that is less than or
> equal to SEV_FW_BLOB_MAX_SIZE, but larger than the data that PSP
> firmware returns. In this case, kmalloc will allocate memory that is the
> size of the input rather than the size of the data. Since PSP firmware
> doesn't fully overwrite the buffer, the sev ioctl interfaces with the
> issue may return uninitialized slab memory.
> 
> Currently, all of the ioctl interfaces in the ccp driver are safe, but
> to prevent future problems, change all ioctl interfaces that allocate
> memory with kmalloc to use kzalloc and memset the data buffer to zero
> in sev_ioctl_do_platform_status.
> 
> Fixes: 38103671aad3 ("crypto: ccp: Use the stack and common buffer for status commands")
> Fixes: e799035609e15 ("crypto: ccp: Implement SEV_PEK_CSR ioctl command")
> Fixes: 76a2b524a4b1d ("crypto: ccp: Implement SEV_PDH_CERT_EXPORT ioctl command")
> Fixes: d6112ea0cb344 ("crypto: ccp - introduce SEV_GET_ID2 command")
> Cc: stable@vger.kernel.org
> Reported-by: Andy Nguyen <theflow@google.com>
> Suggested-by: David Rientjes <rientjes@google.com>
> Suggested-by: Peter Gonda <pgonda@google.com>
> Signed-off-by: John Allen <john.allen@amd.com>

Acked-by: David Rientjes <rientjes@google.com>

Thanks John!
