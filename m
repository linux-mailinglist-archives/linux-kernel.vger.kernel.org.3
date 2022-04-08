Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382C94F8E3C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiDHEu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiDHEuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:50:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ACBFABC8;
        Thu,  7 Apr 2022 21:48:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s2so7415936pfh.6;
        Thu, 07 Apr 2022 21:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s+UL35WfzSMP+2xZp9ViJx/yOJroVs1rmRwF6Q3Unm4=;
        b=q0t5/nAt60OyqMBNKQ++uAnrvaALWWqLYOBLTx+WJzhYM5VyQ9OTyOym80McY8xXE7
         WsiiVk5/T8n8ZdKsS+K/FeLF9CBXGrsm++o7SJoccq/hDBt2FAKrRI5DdUEoNmPsNP3V
         b6AYP8OBZk/7u4zNRoZtWmB/cjg0yQ+Yo3YYA2Wi/ON/5mMLmuxGkGwboCKbzt9fTr9r
         quWl+0QlNS6BO3uxBkez3tTxTQ8EV1sBGOZ1NOeacvwpFg28fjKhZSJctrx/gTV2r+YH
         jniaPDF+QI07VmzUbZyKSvAWIn+NqJ4bSMzPxoyJoVfEMb19JWueferf3NDNRvqvwfV1
         MN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s+UL35WfzSMP+2xZp9ViJx/yOJroVs1rmRwF6Q3Unm4=;
        b=lO5hKuJgooVVuTLs5/Px4FkQft6XmYHNytdCSTWw7nstIvrryz471OOaMr5TzPd7Dx
         TuotuH7+FCwYkQ59N3xsNIGbltV/UZP3l651a+qlUpLgAao4Vwha6UPXeInMkRkUNgDz
         fiPWEtF4Sjvl1OjfAEn5YZdU6CXBjq7tlbeBvmcCuYtbOlQKlxRHbH/BosS1VaCgD1cS
         GPbVO/mbZsTDaeP/DeGPcsGCnrHoBB1UDX+/dtxbdGge9HcU0x/oQmCeYjEQY/mDjSUI
         MKuX9wXsF/EDia/rVx9riHQNINXYj6dJB/jcjkiSFWCsDUhWNZKWXmBfklzk/CEUXhuq
         nvww==
X-Gm-Message-State: AOAM532V2M2LU7exZEFqPe0j2B/Gccf5lyKaY27yD40dgSn5HShCDoj4
        JFsjveFsBPpR9VctpzHDTkA=
X-Google-Smtp-Source: ABdhPJzXCIq8telM9W/w36lyxOuzOEPAH9qgoif+AEcrH5yfRsvy3mg29DtGFZm+iiLV0mHkAotToQ==
X-Received: by 2002:a63:b55d:0:b0:398:5eeb:e637 with SMTP id u29-20020a63b55d000000b003985eebe637mr13646038pgo.314.1649393331984;
        Thu, 07 Apr 2022 21:48:51 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id p3-20020a056a000b4300b004faee36ea56sm24799110pfo.155.2022.04.07.21.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 21:48:51 -0700 (PDT)
Message-ID: <0e3f7e6d-80fa-7942-3e3b-c42d114243fe@gmail.com>
Date:   Fri, 8 Apr 2022 11:48:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v10 14/14] mm: multi-gen LRU: design doc
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Stephen Rothwell <sfr@rothwell.id.au>, linux-mm@kvack.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
 <20220407031525.2368067-15-yuzhao@google.com>
 <5ea69d84-be0c-2e9b-02b5-92d9442c8aff@gmail.com>
 <87wng1838i.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87wng1838i.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/22 19.52, Jonathan Corbet wrote:
> Bagas, it is hard enough to get people to write useful documentation as
> it is.  Could I ask you to please stop adding useless friction to the
> process?
> 

OK, thanks for reminding me.

-- 
An old man doll... just what I always wanted! - Clara
