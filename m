Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1F356AEB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbiGGWpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiGGWpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:45:11 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0EC4D171;
        Thu,  7 Jul 2022 15:45:10 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso198212pjo.0;
        Thu, 07 Jul 2022 15:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NZ4ZO5RiWec2v2bRuyk2aGsl20aFYgXvTiYMa0/akr8=;
        b=UhOk/A87hdgkNrjMO9sFkC4vtCWwS0RGIxmKWy7AaEol1xKYWEY7YfhmkDnfL09v50
         s3GDzwOaMUn8hEreIlSEnlxfhI7psFwgbt56eO9TW/Ipk7I0yLBZRJo9I3cmTfN1UUiN
         MD7BKDRR51y5zxZoVx4rwtibLZkCGpiH4NSB4jxn0hRaZWK9mFCH0hDe1cJv1MUi6wRZ
         crHZDAMNHgQfErT01mLPUaxKX2kKJ4wPOLJOhhWfufSTwhxqJxnibJw1GvL/IoFYqIFb
         ji3Ywy1iGO9bgRtXASy2g/XOQuhhQV4IKZio0qDRi8vL+RmNijyNxM382/YYzeER7uGL
         +ODA==
X-Gm-Message-State: AJIora8RwOxP5CAG+n+LYRmfRPj6MThDo8o3t2soP8Q/71g1XP+Pz7jW
        n0A1rEBaHEIN42LQ300uN38=
X-Google-Smtp-Source: AGRyM1uMvbzTclcGwOrFCwvnGIh/wVkzYIFtmQLBgVSSEVox4cqEWnJcRb2G+JCmXncwNM9k7nue2A==
X-Received: by 2002:a17:90b:1a81:b0:1ef:9e9d:a08a with SMTP id ng1-20020a17090b1a8100b001ef9e9da08amr219485pjb.58.1657233910027;
        Thu, 07 Jul 2022 15:45:10 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id x9-20020a634849000000b0040d75537824sm26341185pgk.86.2022.07.07.15.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 15:45:09 -0700 (PDT)
Message-ID: <e8981c50-2c80-94cc-8d19-f26440ce3ec0@acm.org>
Date:   Thu, 7 Jul 2022 15:45:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/2] scsi: ufs: wb: Add Manual Flush sysfs
Content-Language: en-US
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p4>
 <CGME20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p8>
 <20220701074814epcms2p8bfb6c00d7364aa704e2d6e60088e6a22@epcms2p8>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220701074814epcms2p8bfb6c00d7364aa704e2d6e60088e6a22@epcms2p8>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 00:48, Jinyoung CHOI wrote:
>

The subject of this email is incomplete. "sysfs" should be changed into 
"sysfs attribute".

Additional, the use of the word "manual" in the subject seems weird to 
me. I think the term "explicit" from the UFS specification describes the 
purpose of the new sysfs attribute better.

Thanks,

Bart.
