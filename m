Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA77586F76
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiHARVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiHARVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:21:13 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD6C9FD3;
        Mon,  1 Aug 2022 10:21:12 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id pm17so5706809pjb.3;
        Mon, 01 Aug 2022 10:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=PIN4B1+zujt9LiBMql7z7J0iPpi02q4Ca3aFC6/SCYg=;
        b=uX0Zi/juFXI8I7baEHIRUIu8+mj60p1BlJp+TK5qkjkrJh3d+sNI5b/ii52MhBwXDa
         ubcELTGiemLkU2AO975hDKkvSZYdsyJItilEUML+thiftoX/c2Mg7SqLkD3s50O+OkpF
         jyGlXkvpG7eaUsN3IyBp2JrEScZreq07KgvSmu7nK4VR8UX48zmU4DlkH+mrzKPLDqNU
         kHOx5ndPCBzwRLndY+RKvTFTELJCknfokq8iV7V6TbSH4v1y4xwhIVSWeJJMt82wvFet
         aWK5Xrlp6Mqhpi6b88xVh+D+8dG0utH+MZttdFD91vz83QSxdG8fAysUjHFnpzm9hQji
         rozQ==
X-Gm-Message-State: ACgBeo1eMrD5wf4C3HygWZHYN1s1bD969740ObDKvME+/My0FvNEzQbv
        wOkFUzUTrOBxSEcJADAz2y4=
X-Google-Smtp-Source: AA6agR6ETjSTmK+NOR8RRKSSy2RLoYq0f95Q5qBeCvVX2eqgmgjwfpPciLHhaHLL9Vibz7xBwoR/EQ==
X-Received: by 2002:a17:902:8206:b0:16e:c738:d492 with SMTP id x6-20020a170902820600b0016ec738d492mr13180712pln.5.1659374471426;
        Mon, 01 Aug 2022 10:21:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6496:b2a7:616f:954d? ([2620:15c:211:201:6496:b2a7:616f:954d])
        by smtp.gmail.com with ESMTPSA id s2-20020a632142000000b0041a8f882e5bsm7833024pgm.42.2022.08.01.10.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 10:21:10 -0700 (PDT)
Message-ID: <1809cefc-0c59-ef6c-c3da-7695722a8b78@acm.org>
Date:   Mon, 1 Aug 2022 10:21:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v1] scsi: ufs: enable link lost interrupt
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com
References: <CGME20220801031300epcas2p25866dfc0158ecdd33ef18c44aa23b155@epcas2p2.samsung.com>
 <1659323380-161341-1-git-send-email-kwmad.kim@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1659323380-161341-1-git-send-email-kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/22 20:09, Kiwoong Kim wrote:
> Link lost is treated as fatal error with the following
> patch, but its event isn't registered as interrupt source,
> so I enable it.
> --
> scsi: ufs: Treat link loss as fatal error

Is this patch perhaps intended as a fix for patch "scsi: ufs: Treat link 
loss as fatal error"? If so, does it need a Fixes: tag?

Thanks,

Bart.

