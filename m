Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF27A4B4EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351019AbiBNL2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:28:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350808AbiBNL2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:28:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACABC6BDE4;
        Mon, 14 Feb 2022 03:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644836710;
        bh=/jEI0qa5et1A5fI5AP02quv5hC2xHhHOiKa1B7BmQpY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Vc/Z2Y4nQv7sFots98IcQCiTdEZZbwjXU650/1G/9ZssKOFBIbJtOfAj4Kuvbb2aN
         vVIKnL3zslcEqlqDPeQobhRoZ4ec79wJKwRULO2vYEyevgy9+pQzzQhxeFZqQkfgHi
         dHU7ZRQrv6jhpfJX4amBI/4saUgt5rfLhY5xtjoc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.168.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s0j-1nKNqU3qop-001x2X; Mon, 14
 Feb 2022 12:05:09 +0100
Message-ID: <ffebaea4-8135-6e2e-fca1-8e9f118ef70b@gmx.de>
Date:   Mon, 14 Feb 2022 12:05:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] fat: Use pointer to d_name[0] in put_user() for compat
 case
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
References: <YgmB01p+p45Cihhg@p100>
 <49a26b7a30254d9fb9653c2f815eaa28@AcuMS.aculab.com>
 <0ecb87dcc4cf42328f1f5a7d6abd08ed@AcuMS.aculab.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <0ecb87dcc4cf42328f1f5a7d6abd08ed@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AONVuZwsErb6wKyc0u0ZjdTu/g4fjzt+2aSTAeYXCLwWk3OOGTH
 GPVQdm/wadZSzxXBacz+2n0780srvUVhG2XiNWsVbgD6OQm28vEeWsAHJk+WHmsm4QMy9yX
 oD7XxUqGLr63EvDMUhR/DNplZifM46ZDbWBz/QYPuSQeTRoNngJGY/6NEH5OVfkZBdRlqQJ
 2/lFQdZQm0PdfS/+Z/7Ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3M2sH2Q9UIY=:afp2wr2FwYnyB758PMvNhv
 4rzNw1+08QTUCBM48Mp+55HJyDr2ZMga2Rnf9QsAa21n9EJpVs8tczkKLQIm3zgy0NUF0Tva6
 P+p/TQRYgryu9wt87SwJvwgYfyN7UVbLGRjrUlOqWqc6LhgJRJUfqdI6Va3SlM76cEBYy7TwI
 5poEhJRGRucUPqWS9Sl+4bi0nz6u+yD5gzE21SKvIZpx2Qeugf1e3CAUNQ+USFVVSehfCVaS/
 kIHmGtXpMS6Q4CHYQHza0A5sPDqh7QTsWvpUVKfoZvZKPE22KaQKD02zqxZZTx2A5x/P4qssq
 2lymyz12kKBLI7btoqz2NemKgWWlAiEypRsK1oL9aAIBM49jxaY3ryAWeYYhSbQhsoY3eKzFL
 xRDh7yD9o0Uwus1HpgELCccVX/GJwKB7qAeM9emxlgvYiREvcvKhB6GP7YIRPZDo4we9n/ipu
 upZmwj6HbNj0RN55RMK2PGOqPqVurQpu3jqE3FSN0l/luibxf85kstDxaOhwMISYfYBCCmnkX
 p+5FgeTAGSMSNPiOSvdfeJ7tunMgsLZljJRGstGzX75yq5GFbaqSptMvdEHdQbm33isBm0IHu
 RomQvBeSvMNyKkI5e7+Dpvprivd6Hftx9Ep+ihoN8JGRcldasICwyCg4lhRuJ0VczCiO5wA53
 CuvO8Y5a8UGpGSqltUU2n3ZveN+7MfEX4EX8U4Rae2Z6mWYx1Pa1n/T9N7sepcZdnUXkEDQMu
 7GqJkwB5BfxMeWbFe8UX+6AvLDKXkLMVjrfiKiZz0zp516Ufs0/SDKgDYfPSYcmjFRdFO/BXj
 dRBP5NrSCusXv1PO82ja54NnHSmVGlMRfT3P7c9PT1FkLe/GjwjMuYtu4nqUuppX2HdbihlV1
 yjx283lktqZqKHfOuEQnXlAN+RzLJYzABSyyEdjWIVW8y5qzJZnmNxEaDSjKt8tEA9uCrkC52
 Z092y7NLt1QoyRjIphmCRqP0XkSnFw7GaFa8UBjlKwuwHoVdKDtn5GT6BPEurlsZfDhaGkF1k
 duKE7HfsvKRo3J26O0/yGQojDpdu3zVzTrN/l6uzDf95piaF/iml8BKpeIIRgo5VgKVmoC21Z
 g6zsYggJw7U1sU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 10:26, David Laight wrote:
> From: David Laight
>> Sent: 14 February 2022 09:12
>>
>> From: Helge Deller
>>> Sent: 13 February 2022 22:10
>>>
>>> The put_user(val,ptr) macro wants a pointer in the second parameter, b=
ut in
>>> fat_ioctl_filldir() the d_name field references a whole "array of char=
s".
>>> Usually the compiler automatically converts it and uses a pointer to t=
hat
>>> array, but it's more clean to explicitly give the real pointer to wher=
e someting
>>> is put, which is in this case the first character of the d_name[] arra=
y.
>>
>> That just isn't true.
>>
>> In C both x->char_array and &x->char_array[0] have the same type
>> 'char *'.
>>
>> The 'bug' is caused by put_user() trying to do:
>> 	__typeof__(ptr) __ptr =3D ptr;
>> where __typeof__ is returning char[n] not char *.
>>
>> I've tried a few things but can't get __typeof__ to
>> generate a suitable type for both a simple type and array.
>
> Actually the issue is that put_user() writes a single variable
> and needs a pointer to one.
> So changing to:
> 	put_user(0, &array[0]);
> is probably fine.

Ok.

> But the description is all wrong.

I agree it can be improved.
Would you mind proposing a better description?

Helge
