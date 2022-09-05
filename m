Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E475AD4A1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiIEOTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbiIEOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:19:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F5510FC9;
        Mon,  5 Sep 2022 07:19:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b5so11582397wrr.5;
        Mon, 05 Sep 2022 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=stlQedaCovYr3yUbpgMn7euDx+MBNSry9htNFCiJjpk=;
        b=jwm9yY2trEP5MtrBTgCX6JICAQs0HM5fMGSRkOOnyEmtOJYR7yRJL1KeLstoDp+Ivj
         zAgI8Sq6F31yYGHaqiW0Usv0IbBZHlle4hdrOgOX1pL04Iu42HBC07TSbCIt6jP/fyqo
         pbv2ofWkEk1wXa6pxdDkRQrb/2nzs4MAk3+bfaHx3dcKx7VX5PAeoWQYzXQb5+/RJu5B
         RD3QOoVSPxuThzM8G6Vfb5A5td+eJPFE/eCXEzlWhdI6firTEG8p7KxvwqyHok0vH35Q
         f0S/jgEoIWn/5DHn6/agYviHqHjiKMFdifD3M4/5+vsa2lGzd3E0r/f2R30gySgavjzM
         xUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=stlQedaCovYr3yUbpgMn7euDx+MBNSry9htNFCiJjpk=;
        b=f2t0EVoi/GLVib84CwutlpThr4iBUegTdIOrSSF7P70qE776VZ7aSTv58uEJLfJVUw
         15HFy3kjVUpG0huGKE76zY6vOGMDnSWDAGt3trarQi/BcJZHLwvtyFis7G0CVmfHU16Z
         BnNmli8ooZOw5hx7BK1faMJiW89Wk3GGUSbffs9tq+iW1m6GQ9c1roCMqSv9JlzNI9d/
         1KfiS+RsJ0xpTc3jJgtZhmXIMJ4EDZZPBJLSXnF2Ju+EUu3rrs3c184VYe1oqDgc/Ht/
         Wje/OjBNMk5RYyFdEiUU4A2SjHRHZXis3e1hEMsPHiHDHHjVN/GjL1qTb8Ierr/sDMM7
         oUbA==
X-Gm-Message-State: ACgBeo3UZeh9o5j3HyMBkcX1mV73RK4RkcWXWKQkR3FYA0Gq94ePNSFl
        IxrxGH6iFQOatOzXoTVbsMk=
X-Google-Smtp-Source: AA6agR6l4978ABwQotrtwoAGrhIZMTfS9y2N0NtSPu71LFNsh4tslFZpYd+5zS0xrZhjapwCEzxmsQ==
X-Received: by 2002:a05:6000:984:b0:228:60fb:e364 with SMTP id by4-20020a056000098400b0022860fbe364mr5745528wrb.66.1662387585062;
        Mon, 05 Sep 2022 07:19:45 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id d9-20020adffbc9000000b002205cbc1c74sm8965698wrs.101.2022.09.05.07.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:19:44 -0700 (PDT)
Message-ID: <2ddf55825b3f662e22fa065c0d32fb52cec09003.camel@gmail.com>
Subject: Re: [RFC PATCH v3 2/4] ufs: core: mcq: Adds Multi-Circular Queue
 support
From:   Bean Huo <huobean@gmail.com>
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, bvanassche@acm.org, avri.altman@wdc.com,
        mani@kernel.org, quic_cang@quicinc.com, beanhuo@micron.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 05 Sep 2022 16:19:43 +0200
In-Reply-To: <04f4949e4dea991a93bdf6727bf12948ecc586be.1662157846.git.quic_asutoshd@quicinc.com>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
         <04f4949e4dea991a93bdf6727bf12948ecc586be.1662157846.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTAyIGF0IDE1OjQxIC0wNzAwLCBBc3V0b3NoIERhcyB3cm90ZToKPiAr
c3RydWN0IHVmc19od19xdWV1ZSAqdWZzaGNkX21jcV9yZXFfdG9faHdxKHN0cnVjdCB1ZnNfaGJh
ICpoYmEsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcmVxdWVzdCAqcmVxKQo+ICt7
Cj4gK8KgwqDCoMKgwqDCoMKgdTMyIHV0YWcsIGh3cTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgdXRh
ZyA9IGJsa19tcV91bmlxdWVfdGFnKHJlcSk7Cj4gK8KgwqDCoMKgwqDCoMKgaHdxID0gYmxrX21x
X3VuaXF1ZV90YWdfdG9faHdxKHV0YWcpOwoKSSB0aGluayB5b3UgY291bGQgZGlyZWN0bHkgZ2V0
IHF1ZXVlIG51bWJlciBmcm9tIHJlcS0+bXFfaGN0eC0KPnF1ZXVlX251bS4KCg==

