Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AC1536E77
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 23:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiE1Uly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 16:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiE1Ulw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 16:41:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE971CB32;
        Sat, 28 May 2022 13:41:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso7238378pjb.3;
        Sat, 28 May 2022 13:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QB0d8qPqqCPIVqXchb2VdwSKncU7jZ9Koj6t/ZPBJPs=;
        b=lbHHYp98pfQzfkZj3OkgqeOlQACSzbfJ2B36eVuJsL25lGtHjWcf/LCbx0ULa+RChO
         AhFAGdfvRml+yHHrtBQi3mDNnwRw3m8qmcQJ+SwmgOxXTM5pmSakup+hxlHrbFApTS2C
         Juv6CY/k7DKTl7cOWAiBlfBLfNR2zmzMSCipq+hvY8DBnQL9TbqnvQZukUWGcgAUXTZl
         PAhMbwb4pkxS3pysoc4ZuqVRMJwY9E5IV5TXh6mQzvOodM0bKLi8ueN2MLbMnGa3q9Ig
         ZFXHxX6qZFr60p1nGBqCvM1QJtIGiBmV9HFy3+YXpuENImS06bBWYyDAvMV5H3wiev5L
         2XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QB0d8qPqqCPIVqXchb2VdwSKncU7jZ9Koj6t/ZPBJPs=;
        b=gFswJSEIZjyaLFPWOPoApSfRGRInVQ1/bcWIOkB3IGZBfjkqOdd3MIcE0S1vHzFleC
         DBc3I1kPLxzTqQgI4QpnwPc9IBEPqadaZ/4yqJHFWeumm4SJTMWtAwzHA2B3wI1WfJN5
         ttDUdHoncf1449F2zVUE/5nbBoSOhvRe8PdCqj+dPHAm44kIwvnF0WY/4ydQkiG4GVDX
         7PidlXKZfq4hRZ1nmsEr+zYvihn0XPHjOSBzfwjoLGxsMFPPqIaE6d08LfKdR+s/GSnQ
         /phXe2k0FsrwBxDL9VyDDXwSO5yRP3BdwWNKT1wttVJKJ8SXzNDyeu9D2RpIkg+OnODw
         tDqQ==
X-Gm-Message-State: AOAM533Azc1LUnICmmMicr0zyrpplzcU0VHv049PEOY0w0f89dcK6N5M
        yK6b9WQn7dl3xIeERv46tKONBTrKDHM=
X-Google-Smtp-Source: ABdhPJxxfbYj6xnqc6bpdSYCsjrm7FP6qVTfYLOog0RVHQcTCFl2VbTOUzTRLLO1wJjZVkoXWb9iUg==
X-Received: by 2002:a17:90b:4ace:b0:1df:cb33:5e7e with SMTP id mh14-20020a17090b4ace00b001dfcb335e7emr14798336pjb.5.1653770509468;
        Sat, 28 May 2022 13:41:49 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:781a:4ab0:a93b:176b])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79852000000b0050dc7628195sm5852011pfq.111.2022.05.28.13.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 13:41:48 -0700 (PDT)
Date:   Sat, 28 May 2022 13:41:45 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] dt-bindings: input: use generic node names
Message-ID: <YpKJCQ0hCIw9hb0m@google.com>
References: <20220524093136.7980-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524093136.7980-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 11:31:36AM +0200, Krzysztof Kozlowski wrote:
> Devicetree specification expects nodes to have generic names, if
> possible, so replace custom ones with something generic.  For gpio-keys,
> the more popular format is "key-xxx" instead of "xxx-key", so choose the
> first one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Applied, thank you.

-- 
Dmitry
