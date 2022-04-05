Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426CA4F523F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849835AbiDFCkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575964AbiDEXJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:09:45 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871A735878
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:40:34 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 7so643188pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=+VkEMKPsUn5codAwC2objI7iKq9LeQy/6DGModLXRws=;
        b=a8L5o5P9uTOesLLONs4iibuBLPNtqXkJvnT5lW7YCQHxQj+KHSe3RjpJncrX2lwxya
         m0fpQalAUhuzaUI4Tcwrw1xxjobzM5WSzUovJuKD63HaCOAusMNombgK9/8bW0kMD9RA
         uXW3PuCngloNczariQrjxBBTI4pEg/lF5UhdpHu4gZf2rRUUsPk5RzgzY2vdluwR9223
         pvjyjRYpy+K2FvL0jB38jXUwaPr6w56Vx3V/I/KUvL1Eg21tAnG7cNwW8ZB8IVEFLgFp
         9d8bP7jb0a04ePZkHF8/bcPfS16jTZpInlewoW8Mby/pG/YZ/tNxtGBvPi8vwpW/VET7
         WQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=+VkEMKPsUn5codAwC2objI7iKq9LeQy/6DGModLXRws=;
        b=FpTPrBTWHMVWI0N0SYaieCVv26+dNElqCj6mbvQh5xstFXCYkorADC4PwSUy8RPwSm
         oIVKkruPj9x/voofInSgF3+ZhALGakbBn1ztaSSjE8coAj9LsFjnZxCfTC2fAOiv2/vB
         zjn+fX49v8Quy6yiJk8Jd+JABp2y64Q8Tp9xfycp+i6KLt8u6qgDdz4I+Q4ZkfrA1kBS
         5rYD/QlgWjKWi2XRtVI3vElF42wnbHp3NakHMU2CY0AJ00CairHeP6yQAgfYpnN1PKQu
         u1WR8GKzSDL0K3GZwDgGSanq1oG5fhujdungU21JzFWziQet5LJv82lvK74cM0mfYZrr
         yhmg==
X-Gm-Message-State: AOAM533WOBOQi34HWbVpQpeN6DQYk1G6JpAOwCChjtioRyQQ4DcXFAZi
        /YriHqIRGu3gZDcklT5YG2wYFA==
X-Google-Smtp-Source: ABdhPJzohfbOUrOhh/eLDwWhPKl7DNSBnOmqX6sET9SS3mk7vVXphuAZWMw56KG1ZqqSbTanxtD0Bg==
X-Received: by 2002:a05:6a00:1341:b0:4fa:a3af:6ba3 with SMTP id k1-20020a056a00134100b004faa3af6ba3mr5505300pfu.51.1649194826458;
        Tue, 05 Apr 2022 14:40:26 -0700 (PDT)
Received: from [2620:15c:29:204:be3e:5e1c:99cc:513f] ([2620:15c:29:204:be3e:5e1c:99cc:513f])
        by smtp.gmail.com with ESMTPSA id o30-20020a63921e000000b00398e665e830sm13002381pgd.48.2022.04.05.14.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:40:26 -0700 (PDT)
Date:   Tue, 5 Apr 2022 14:40:25 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 6/6] slab, documentation: add description of debugfs
 files for SLUB caches
In-Reply-To: <20220404164112.18372-7-vbabka@suse.cz>
Message-ID: <fcf0fbc-b464-cab-e8d7-ae1322b2ffb3@google.com>
References: <20220404164112.18372-1-vbabka@suse.cz> <20220404164112.18372-7-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022, Vlastimil Babka wrote:

> From: Oliver Glitta <glittao@gmail.com>
> 
> Add description of debugfs files alloc_traces and free_traces
> to SLUB cache documentation.
> 
> [ vbabka@suse.cz: some rewording ]
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>
