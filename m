Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8207A59C40A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbiHVQX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbiHVQXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:23:54 -0400
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3F8E0BA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:23:50 -0700 (PDT)
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
        by mx0b-00364e01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MGLfC4014271
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type : content-transfer-encoding; s=pps01;
 bh=nNg3+xLbzEB5TIQhmklxgT3ZoTAReamxKtezVw1wVlM=;
 b=QW0lghpXxI7WrwuJAKReuBaF7WmB4egi+YS/QlFT0jBVVNNnE/fynb8y0fhw+HaflcLj
 uD5Gu0uGFCeTf6WYO1KfUsAtYskiqxgSmdx0BNk8QqlGqO9jswdmWFelOsY52vBUcO4B
 moO6uQeUrw2xIs/7ltzIBYyUsE69okT4ZkhLHdmt5UW/23BKmBEDjgWpTr5yYbX0Ffwh
 rpwoDlrBEACO/BSQ+8mt7/Au0OEAOnH1xZLneF6MEjnjjUH9MQMmpN4pUcJHZ+PWTJgt
 mpZLrkK8ho72owVxN62Y/mDM/aNzeW3fPxRNBeJQGFaw9kdfEyIFMtqYpkdfJLn9qyyB 1w== 
Received: from sendprdmail21.cc.columbia.edu (sendprdmail21.cc.columbia.edu [128.59.72.23])
        by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 3j2wj5bgwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:23:49 -0400
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
        by sendprdmail21.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 27MGNKCg097797
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:23:49 -0400
Received: by mail-ua1-f70.google.com with SMTP id q8-20020ab054c8000000b00383a1b97212so2277749uaa.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=nNg3+xLbzEB5TIQhmklxgT3ZoTAReamxKtezVw1wVlM=;
        b=LCOqr/DsSxwll2CO5QekzjA+a3KveWL3m1en2yX5cQBKJliqi23Jqvw7RNmfKJuHNB
         zNL6j0pM4CsyM7mWYiJfhf1tIhgDRqZH1QULfK5JQoGsdNDZzxhdGkhcLoeABpgXIAm+
         bjKXgvxrMI7OxVzZHX/8DGqW/TYZSU8bcvMF/bIpRZ/HAoziDP/AIVkH4diPOuxWGQfJ
         HnVYHF0pnCHcf4x3As0/YuHFgxyM+tmmXocBHvWmAKOBDpYGqc4CsJajBwMNjN8pwFTA
         ALH4nZPFrXaNPly+4dw5NBdZfEhyyVrfT7hH/OyPryb+Z2znvw446BgtPy3l9b6JrbmM
         KYXg==
X-Gm-Message-State: ACgBeo3OYHgOytR6ho8BW0E1PKSLDdbOdFMcQhwmJ0nQU2DDAC5+tPvi
        1VZ87J5wmA5CFTAcAoQx6ssDASp8syZtMmbi1o++oC65HIvogs7IpuE08SCGsxT76cg8AhJyI8w
        UxXgrk+okQm8+EboY7YXvqrREwDCkIkFbU5YtJEiTkdZFbrfW
X-Received: by 2002:a05:6102:5490:b0:380:3982:2f97 with SMTP id bk16-20020a056102549000b0038039822f97mr7406550vsb.84.1661185429042;
        Mon, 22 Aug 2022 09:23:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5q6SPrJjxuIl18CZC1pulVqW+49GzrIat3iewIkEtcOWg2YVzMSKn7SNwOprCSHkZLtvOk+L0yvhDy4p0vwPI=
X-Received: by 2002:a05:6102:5490:b0:380:3982:2f97 with SMTP id
 bk16-20020a056102549000b0038039822f97mr7406541vsb.84.1661185428835; Mon, 22
 Aug 2022 09:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEHB248ZfrhSr3V3Ag59fCPoBmm+O==mFrgq7xQipoSgew_Row@mail.gmail.com>
 <20220818192852.0934313f@gandalf.local.home>
In-Reply-To: <20220818192852.0934313f@gandalf.local.home>
From:   Gabriel Ryan <gabe@cs.columbia.edu>
Date:   Mon, 22 Aug 2022 12:23:41 -0400
Message-ID: <CALbthte5MZbXfWh05NqHOXvUWx9dLL7OxT9Lf7+aALiYb4u_5w@mail.gmail.com>
Subject: Re: data-race in pcpu_alloc / pcpu_nr_pages
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Abhishek Shah <abhishek.shah@columbia.edu>,
        linux-kernel@vger.kernel.org, mingo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: sdPzr4egpu5duuL-uWXtaSL8kGl3NHxn
X-Proofpoint-ORIG-GUID: sdPzr4egpu5duuL-uWXtaSL8kGl3NHxn
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_10,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=10 bulkscore=10 adultscore=0 clxscore=1015
 impostorscore=10 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208220070
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Makes sense, thanks for taking the time to review this for us!

Best,

Gabe


On Thu, Aug 18, 2022 at 7:28 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 18 Aug 2022 18:29:00 -0400
> Abhishek Shah <abhishek.shah@columbia.edu> wrote:
>
> > Hi all,
> >
> > We found a race involving the *pcpu_nr_populated *variable. We discover=
ed
> > that the racing variable is used in meminfo_proc_show
> > <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__elixir.bootlin.=
com_linux_v5.18-2Drc5_source_fs_proc_meminfo.c-23L123&d=3DDwICAg&c=3D009klH=
SCxuh5AI1vNQzSO0KGjl4nbi2Q0M1QLJX9BeE&r=3DEyAJYRJu01oaAhhVVY3o8zKgZvacDAXd_=
PNRtaqACCo&m=3DJaafDoHfUv9wBvITwFrxb8GW82J0sFuH-p1ItZM6jxU4b2c4UzG6SAgIIAX_=
vLz9&s=3DAHf4mjYOVq3qPnt65oFSjl4kztRIYFGagjntxAqUFWE&e=3D  >,
> > but we were not sure if there were other security-relevant implications=
 of
> > this race. Please let us know what you think.
>
> So you see that the number displayed in meminfo can be written to while
> it's being read?  As it's a long value, it is likely to be accurate (the
> value before or after the update). pcpu_nr_pages() is only used to displa=
y
> the number of pages in meminfo.
>
> I don't see any problem here.
>
> -- Steve

--=20
Gabriel Ryan
PhD Candidate at Columbia University
