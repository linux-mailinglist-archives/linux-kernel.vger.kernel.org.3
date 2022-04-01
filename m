Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC8D4EE69C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 05:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244455AbiDADRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 23:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244446AbiDADRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:17:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318171F2DCF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:15:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so1313719pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=n8hOLLPsioMTcoCNTRHF3hQIlwNjVgqY58f3ylTkMB0=;
        b=5jX7ab72vKtRaQPW4oQurv/GfnG36FTSYMgaDHqHn12X0JBozMk++6pUe2qhNxWIk3
         qTj8lLG3Lqkx+5NpU/uPJfKoPGfVg7QHeEj+fhf2YhPZOkQI4O9GQrnqmpx0Wbf+FHI4
         RagIBN7XUdMAAGFub/TBiwEo0WwGAM8riBsQr8zO8QnH0CZcwfjb8B5ol0yG3JUOOarN
         HIl4OLe9muHJTP4DXPgBm2tX0UKE7kTGFVy/ncncLVxSbTsEZ3Z/1ZtGGRy8wgsux1eU
         qdkXQM5UwPeikUfvbxB7gvPBYt6qdMcIM/eZJA5kxzpp+HhGFJsTu/qYXCzsDzDy8vW3
         9I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=n8hOLLPsioMTcoCNTRHF3hQIlwNjVgqY58f3ylTkMB0=;
        b=uH/wJNwdiFm2toeqjOOiVO+vajdpGo1Voe3QxZW9TeQcn/5ia6J8vPWKUML73IppQb
         4yg/H8TVJc8OccDG5B9mrgqeek55y8JaX5l+SC+KKFcx4n/zcNunzXJWfMpIX81YIK4V
         W/Cu9TS+HPx6MPfmXZ5LB+O9s7q+EnOpzlYd75hShgLL7fVm209N5MW4xQN0mnUQLu4X
         /5HfaGB5/7Co+wbhDwlmBj/nDQMoZ5on1S9FWLEP+IqZ0nwfKSa+cyu7q8UIcRaqPpQv
         UpkDgCs5xn4L8Q83DydKkUQ/XCQdYTYQv/Tm8MENkFFjYxoU4+MHxEEJKcr5NK3JJAOR
         jjgA==
X-Gm-Message-State: AOAM533zocEmMSs1hVv8631Icsnd9WEvpKtMQh/fwapwRGejdJpGXbMg
        ivupgFOrcO5NJyfks7M9M6fMrw==
X-Google-Smtp-Source: ABdhPJyszJrZDJMk9RUvgQvjV/bDttD3i/of9SsbOehtJAf9DGs7E55YAO6YH2vzJCH+9pU2298oDw==
X-Received: by 2002:a17:90b:3ec9:b0:1c7:74f6:ae6e with SMTP id rm9-20020a17090b3ec900b001c774f6ae6emr9496389pjb.212.1648782948618;
        Thu, 31 Mar 2022 20:15:48 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e6-20020a056a001a8600b004fac74c8382sm901520pfv.47.2022.03.31.20.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 20:15:47 -0700 (PDT)
Date:   Thu, 31 Mar 2022 20:15:47 -0700 (PDT)
X-Google-Original-Date: Thu, 31 Mar 2022 20:15:44 PDT (-0700)
Subject:     Re: linux-next: build warning after merge of the risc-v tree
In-Reply-To: <20220401114146.25ef9683@canb.auug.org.au>
CC:     Paul Walmsley <paul@pwsan.com>, Atish Patra <atishp@rivosinc.com>,
        atishp@atishpatra.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-981d3b11-ec5c-416d-9ecf-383f22c4f913@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 17:41:46 PDT (-0700), Stephen Rothwell wrote:
> Hi Palmer,
>
> On Thu, 31 Mar 2022 17:05:15 -0700 (PDT) Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Tue, 29 Mar 2022 09:46:57 PDT (-0700), Palmer Dabbelt wrote:
>> > On Mon, 28 Mar 2022 19:34:12 PDT (-0700), Stephen Rothwell wrote:  
>> >>
>> >> After merging the risc-v tree, today's linux-next build (htmldocs)
>> >> produced this warning:
>> >>
>> >> Documentation/riscv/index.rst:5: WARNING: toctree contains reference to nonexisting document 'riscv/pmu'
>> >>
>> >> Introduced by commit
>> >>
>> >>   23b1f18326ec ("Documentation: riscv: Remove the old documentation")
>> >>
>> >> This is actually in Linus' tree.  Sorry I missed it when it was
>> >> introduced.  
>> >
>> > I guess I missed it too.  I just sent a patch to fix it up.  
>> 
>> Coming around to the fix reminds me that I should have asked what you're 
>> running to trigger these, as I should probably add it to my tests.
>
> I just do a "make htmldocs" once a day and compare it to the previous
> days results.  You will need to install quite a bit of extra stuff for
> sphinx to work.

OK, I guess I'll throw it on the list but TBH that sounds like something 
I'll never keep working for long, even if I do set it up once -- I'm a 
terrible sysadmin ;)
