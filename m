Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4CF4C28CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiBXKEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiBXKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:04:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727A0285AB3;
        Thu, 24 Feb 2022 02:03:59 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21O7idsH015524;
        Thu, 24 Feb 2022 10:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=idAS+IlW9snUh111HZsCYtkkTXtUPo4nhtMY1Y5Hkto=;
 b=qj0x6hKJuBKEhotYVHwB+DiBvv5gyxcU9qIAo+hVvNthJMoWtZ8o48Hul3vlLCopI17h
 jbNbw/Hb/a1sQ05uzzsBsmw6ECkA5ArjzmFhQInxplRao1mKS3lJFunFK70gqmUUJpLX
 ceu8q3gFVlHPnl5bS4gnAcgYd7i6/RxiCQua22iosVWHqxXRqmCtzenQMkc5TRRDV+jZ
 IUrIN0bCst7N5w27+OO3jMvHJD/EM3+ZuLc3RoGONSievtW0YCFXxg/AOOwh+ddAbBie
 w0ZuIF2rnZWpaZTKKrcWBnz7bxB2jF6dJMUEumJfml5bTFVYD66cmE6d1CJYayQa6ukG Ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecvar6hnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 10:03:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OA0s5x020755;
        Thu, 24 Feb 2022 10:03:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3eat0qjcfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 10:03:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCPKzsODn1IPUn5nBn/bh5WJxV/YBhGj5lQ4LqQkSUsleh+0dz3GQU5n846lbDHQGzSjmcGUKlLUh6kvsXwB2CcI4vYPn/8I/ZlyIR70sotF/sK6due4QPgOAauCsnTOd1jEY279imQc6CVYFhKdMDUsaJniJ5/0vdjy1Ijr9L9DN84Dqw2NekLMqTsf5/CAxMFcREI5fdK3B5QNk5bPBmze57MvNzBTY5S8sHgrPsi879UQRUfZLg4ScSphKccxpEQRrvehuIijrT0s5dKPhYdNAOanZkEyxuQowmG+oUuQz3IpWY7ovgDYSZsflqYsa+roiL1uBH3KR1XErFYFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRPL9AviS+ZvRCn+U69xw8xgjAO6CjfTvcMNhqANV3o=;
 b=Kj3hr0G6YPI393w6s2JlfQ5vbGuki8ymHgdR//XWn32pLdBwCagUzM9hvnuo54ruRQW6rLoMOMHkrXMBu1l1Od1e++i/FJTb5W/JXQb9sD/2RsDy7U4dZPECH1FGzLqGVCQfr/Pq8dUahRhRMUkqH11cVOMkh3Qc9us3giyKP0KH9LCK3J4l5iwWief2S9tmyFrjq6TQS5bBTHo617f8iykXrFSO5cZ/E4XdlbaLGqM/POvfTDg/17b7SmXDrxZjHjf9dDrow89pwHXC70Q9WptQ5fcQ39Crfo/1rTatvPsQHspmMDA4dEHKiq17bD6Pvni5QXjzMVAdwxomNFpj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRPL9AviS+ZvRCn+U69xw8xgjAO6CjfTvcMNhqANV3o=;
 b=tSsJlQp4uWOBZwfG4y7vq26wRhrhSz/gN8eVI99Yq2Bm98O3ayJ/grn1q1DoZXkLvsTCICd9gkc7xYYGW2rRyTORkZaIUXmEIUrqDk5GK41FB8T7jYZx/LudgGniAG3RGGeiHF/N+69ZvkRQGfIWuAg0tZqtgcg+4XAznT8zi80=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5468.namprd10.prod.outlook.com
 (2603:10b6:510:e8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 10:03:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 10:03:52 +0000
Date:   Thu, 24 Feb 2022 13:03:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vishnu Dasa <vdasa@vmware.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jorgen Hansen <jhansen@vmware.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "acking@vmware.com" <acking@vmware.com>,
        "dtor@vmware.com" <dtor@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 3/3] VMCI: Fix some error handling paths in
 vmci_guest_probe_device()
Message-ID: <20220224100330.GO3943@kadam>
References: <cover.1644531317.git.christophe.jaillet@wanadoo.fr>
 <c5c1a5f3547bea3c4a1cfb8474db683d83c0ca1d.1644531317.git.christophe.jaillet@wanadoo.fr>
 <20220211140950.GN1951@kadam>
 <1bc15512-d811-b26a-d4f3-e14b30730c00@wanadoo.fr>
 <85DB8130-D600-464E-9717-1A0AFE795EA7@vmware.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85DB8130-D600-464E-9717-1A0AFE795EA7@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::25)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08a8a405-bacb-456e-42b6-08d9f77cf5e7
X-MS-TrafficTypeDiagnostic: PH0PR10MB5468:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5468CFD96C0AB98D2221E9718E3D9@PH0PR10MB5468.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvGCAwoLDGUCstI5pTrv4IeRzM1SzrpfPIqbhWvQqULAx5dCBc925PB/774Yv5qd0W2hiA+L96uqrJC1UncNVcgZbl6Y7fCOiN0pw6MnOPGaDeUpDQcWscufYJRcR/rksknXoxEHLoP0FZqikEQxVI0xCx4AW3vbnvjW0UMTMXOc3Wy58t79lboO9yKL7G2ougFbh19Vg/qBW/7VuwCR3G5VvH5HMqYbtqfoYBtbmB4Ef5l4YozlHdqq+hOfTTHqWTWCAAufQbfpBHnWMoAs4pM1LmbKcm+bpIfp87sTrWNazdh4Gu87VcLx7nYyz2Z2MhnJasut6GZCQXR7wAE2+tkXCda7QlaClIPvyG/0nwQCZn3QruIjd+GIZGdEfy3heHfk7xuK37HsWuEz/REkeCC2nzIQWMof4b7IISSTbotJBeW2O0vfSP8Hczxz8q3Ix+3HLfd5XmGN42pPdOy0mp0SrWxJEaE0TRoZE14QC1tR5yCtL2+Uza97WtQ2JbFdKXqhMAxYznXt9CO+mkLtrMdfI71TbZg68o9yRrSBcc6NcN43oFeCpX255sl9S74w8qnzT/2PPwsFy7/fAwxBMU3T9MzXUcDWEbEYDYvyVxDo0Dc5NHlNWmn3iA59VtMYWS0kMJIVtYLgVNeox6XYGqqcKqsHoFxzdHvvIaWhaCr6H+mU8Xn7uEthORNC/ukfFoaCJdtk/3XNvx0nm1hI9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(33716001)(2906002)(44832011)(7416002)(66556008)(66946007)(86362001)(66476007)(8676002)(316002)(6916009)(54906003)(38350700002)(8936002)(508600001)(38100700002)(6486002)(9686003)(26005)(186003)(1076003)(66574015)(4326008)(5660300002)(83380400001)(52116002)(6666004)(6512007)(6506007)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JtO466hcjrpkwKHmNAvSRacObAqMzRhA/zF1XwHDQg1HulNdT29ibuZ6PR?=
 =?iso-8859-1?Q?ydfTY7SgzoOXKrVSNWqFsT/Rkl4z+HMxVJ+IqG4bXDAZtcjrZDhklI5RyV?=
 =?iso-8859-1?Q?hnl9jB4PQoYZ8uPUbtsTb6qwC+victS3rhUjud2ePPZaHsQ13GaQDk9GEM?=
 =?iso-8859-1?Q?nm3iz3wdGaaUXSDiXWb6F2e8OHV79bTx/iintwof4LZwvQFEzQa7chK1VM?=
 =?iso-8859-1?Q?wekQYJU1Aos9fP8SOsyeh9GOociSq9CPwDx0Ee8zcx3MzvWG657Cqx1Y/j?=
 =?iso-8859-1?Q?BbfK20vjGCmb60VW0sNzRMTISEzxpSJNQrRxN8TxwSS5YA310XIOqYkAuy?=
 =?iso-8859-1?Q?k3OdV9IWKX+L54J6H97KmV4efHz9VlD2Ok+TGXcP/FAapBfXOZBFK4Q4Ub?=
 =?iso-8859-1?Q?zmq2KioA2LbXlXp+cJsrPPtLq3CnUDUVe17SYNwq5X9iIcMnCxw8nQ6YzG?=
 =?iso-8859-1?Q?89rK/QsZPjkH8kUbF7KfyL2sblBEadp4ANrxmQlssDvyzKh+8cu8uFhMav?=
 =?iso-8859-1?Q?N6k7I6twATEZX8kdXAJ2tVpziUrtXCkCpUlNhM30sDblBxhU2vEyo7ApFY?=
 =?iso-8859-1?Q?roSnZwdnpyP1E6hexChH9D8TCQYbyc6WYBhvFHz9pt6D1Aaq6RfMatsvPj?=
 =?iso-8859-1?Q?RhE8lNMCUzkCpPF9UCsZJOFHxnCTh9SfSJ1PpPgUbXz5fBQKjCyd8muYB1?=
 =?iso-8859-1?Q?eaaMs9SUMmRMhP1zCrKWgtC+GopfQ2HM0PzbSArcwSSRN8BJmUEdFecq7W?=
 =?iso-8859-1?Q?x37nqUYSfHm9e+dBPQZjGX2tkmyA0cM5fkZAuIcB5LrlWhlAzXRpkg4CFM?=
 =?iso-8859-1?Q?RGZKPLBr6GAy3Gg9d8SUJL7/JAFn5gpjTodk8oNk4ODBQHW0TQqPpVIH5p?=
 =?iso-8859-1?Q?jNQNi+eSirTjkkkj+h4JzDXIpmXj1ly3wdOEkbAo1tYfincRXkhRl4N7+R?=
 =?iso-8859-1?Q?52QeS+abj1eivtKi+WsK5rdT8QhApD5hBwqLG6iOGE/WrqNKBUg0X58VLQ?=
 =?iso-8859-1?Q?fUOKFeomd3vi9xv6w962owsB7jCylsYLE5+HtiuJKOzMCqOLaTWd7HlJSD?=
 =?iso-8859-1?Q?3Edzymir3VzmcjS+PCCRe9YoXe5b6lXM6LXp9WsPXeqxT+q9eYfJpmS8rZ?=
 =?iso-8859-1?Q?ouJhgk8nW8HAQuGiWtZ4nfJ4HfcFwpjw3OX44NlP6RVaLUusK2UIPVN/YU?=
 =?iso-8859-1?Q?zjOkZ0JYa5GbSWyenfxewwDd0YTeRXYoNYRyOb4j9AI9R+HOepbkQ8jPf4?=
 =?iso-8859-1?Q?T0j1vUSf9SqEfZBWtixNHIzDTbaYLH/UnA7IOW+612orNr7D3IDmD7rlg3?=
 =?iso-8859-1?Q?dx5VuImYnogQPnY9EBdZn+eWw1mFZQwNY82bixYyueu6lVsGkI9Wkduy6r?=
 =?iso-8859-1?Q?zteGpl4GK4jFkHRzUxGBCk8EzhRRrdiZcwxzlOVCWyZ9fj5Isicimv3q1v?=
 =?iso-8859-1?Q?5YqQJlw4VizJw6D+ZDiF/vLxN0vuV05TAi5lvM8BNHf6/D8Szi15GQst9s?=
 =?iso-8859-1?Q?rV8Ft3Zc/PPQq7/mbyHj+UMWbIvLelGHmSFwcv5SzfpUeu4eS1qw1bd+f1?=
 =?iso-8859-1?Q?WZ+dPK8llAr5BWwwrzX4+ONl51M5SiiGXyqyrdZ0KXzPitXU1cg0I5ERBO?=
 =?iso-8859-1?Q?5igfgEVy9SnINeO9u9hFMLCS6dvJChxf2xcbYeaVUqvsc23PoSg+C/aN98?=
 =?iso-8859-1?Q?/iIgaLuW9AmHjV8epMzohLwbTaPwZtx2LRXhWU+3bR3jRLOL5IWtnZJ9S5?=
 =?iso-8859-1?Q?cskg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a8a405-bacb-456e-42b6-08d9f77cf5e7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 10:03:52.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hByILNIjjQHdUXgYVjWl7uBvi0XshXsdAHz1vTeGS9ECiD7LDhmPsKioxwYsDsGL2hAz+IfL+9Ix/SfmPaXNJZW8wubqSl3ZVWvsaKDOEzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5468
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240059
X-Proofpoint-GUID: 4c9huhEOgeFYCVXcYDZ_a9Ow8fh_YF7e
X-Proofpoint-ORIG-GUID: 4c9huhEOgeFYCVXcYDZ_a9Ow8fh_YF7e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 06:53:10AM +0000, Vishnu Dasa wrote:
> 
> > On Feb 11, 2022, at 12:06 PM, Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> > 
> > Le 11/02/2022 à 15:09, Dan Carpenter a écrit :
> >> On Thu, Feb 10, 2022 at 11:27:34PM +0100, Christophe JAILLET wrote:

> >> Whatever...  But where this really
> >> hurts is with:
> >> Alloc:
> >> 	if (vmci_dev->exclusive_vectors) {
> >> 		error = request_irq(pci_irq_vector(pdev, 1), ...
> >> Free:
> >> 	free_irq(pci_irq_vector(pdev, 1), vmci_dev);
> >> No if statement.  It works because it's the last allocation but it's
> >> confusing and fragile.
> > 
> > Agreed.
> 
> Sorry, I hope I'm not missing something obvious or misunderstanding the point.
> But I don't think the problem implied here exists?
> 
> If 'request_irq(pci_irq_vector(pdev, 0), ...' fails we goto err_disable_msi and there
> is no free_irq in this path.  If 'request_irq(pci_irq_vector(pdev, 1), ...' fails then we
> goto err_free_irq and we do 'free_irq(pci_irq_vector(pdev, 0), vmci_dev)'.  Note that
> this is for the previous one without the check for vmci_dev->exclusive_vectors.

It's not a bug, but it's bad style.

Ideally the allocation code and the free code should mirror each other
as much as possible.  If there is an if statement in the allocation code
we should copy that same if statement into the free code.  Even if we
can leave the if statement out, we should still include it for
readability.

Also if we add another allocation at the end of the function then we
will have to add the if statement back.  Maybe the person who adds the
if statement will forget.  So it's fragile.

regards,
dan carpenter

